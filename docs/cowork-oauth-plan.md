# Plan: OAuth for the SecondBrain MCP server (Cowork / claude.ai cloud)

**Goal.** Let cloud MCP clients — **Claude Cowork**, **claude.ai connectors**, ChatGPT,
etc. — connect to SecondBrain with a **browser sign-in and nothing else**: no token to
paste, no terminal, durable across sessions. This is the only way to give cloud hosts the
same one-click experience that `npx secondbrain-connect` gives local apps.

**Why it's needed.** A local CLI (`secondbrain-connect`) writes the token into a local app
config. It cannot configure a *cloud* session (Cowork runs in a sandbox). The MCP
Authorization spec exists precisely for this: the client discovers the auth server from
the resource and runs OAuth itself. We just have to speak it.

This plan targets the backend repo `~/Desktop/personal/secondbrain` (Supabase project
`ntykytpngslkytfyuaee`). It is **additive** — existing PAT clients (CLI, local plugin)
keep working unchanged.

---

## How MCP clients authenticate (the flow we must support)

Per the MCP Authorization spec (OAuth 2.1, RFC 9728 / 8414 / 7591 / PKCE), a cloud client
does this automatically when you add the server URL:

1. Calls the MCP endpoint with no token → expects **HTTP 401** with
   `WWW-Authenticate: Bearer resource_metadata="<url>"`.
2. Fetches **`/.well-known/oauth-protected-resource`** → learns the `authorization_servers`.
3. Fetches the AS's **`/.well-known/oauth-authorization-server`** → learns
   `authorization_endpoint`, `token_endpoint`, `registration_endpoint`, PKCE support.
4. **Dynamic Client Registration** (RFC 7591) at `registration_endpoint` → gets a
   `client_id` (claude.ai/Cowork register themselves; we don't pre-issue credentials).
5. **Authorization Code + PKCE**: opens the browser to `authorization_endpoint` → user
   signs in (Apple/Google) and consents → redirect back to the client with `?code=…`.
6. **Token exchange** at `token_endpoint` (code + PKCE verifier) → `access_token`.
7. Calls MCP with `Authorization: Bearer <access_token>`. Done — and it refreshes silently.

Today, steps 1–6 don't exist; the server only accepts a pre-minted `sbm_` PAT.

---

## The key simplification

**Issue the existing PAT as the OAuth `access_token`.** Your MCP resource server already
validates `Authorization: Bearer sbm_…` against `mcp_tokens`
(`supabase/functions/_shared/tokens.ts::resolveToken`). So the OAuth `/token` endpoint can
just call the existing `generatePat()` + insert into `mcp_tokens`, and return that string
as `access_token`. **The resource server (the `mcp` function) needs only one change: emit
the 401 challenge.** Everything else is a new, self-contained OAuth front door that reuses
your token store, your Supabase login, and your Pro gating.

---

## What to build

### 1. Resource-server change — 401 challenge (`supabase/functions/mcp/index.ts`)

When there's no valid token, return **401** instead of a 200 JSON-RPC error, with:

```
WWW-Authenticate: Bearer resource_metadata="https://ntykytpngslkytfyuaee.supabase.co/functions/v1/oauth/.well-known/oauth-protected-resource"
```

- Validity is already determined by `resolveToken(...)` (in `mcp/tools.ts::authContext`).
  Lift that check to the top of the request in `index.ts` so the whole request 401s, not
  just individual tool results.
- **Migration caveat:** today an unauthenticated connection returns 200 (the in-chat
  `secondbrain_login` device flow relied on connecting token-less). The v0.2 plugin no
  longer uses that path, but if any client still does, keep `initialize` + `tools/list`
  answerable without a token and 401 only on `tools/call` — or gate the 401 behind a
  feature flag during rollout. Cleanest long-term: 401 on any tokenless request.

### 2. New Edge Function `oauth` (`supabase/functions/oauth/`)

A thin OAuth 2.1 Authorization Server. Deno/TS, `verify_jwt = false` (it does its own
checks), same shape as the existing `mcp-connect` function. Routes:

| Route | Purpose |
|---|---|
| `GET /.well-known/oauth-protected-resource` | RFC 9728. `{ resource: "<mcp url>", authorization_servers: ["<oauth issuer>"] }` |
| `GET /.well-known/oauth-authorization-server` | RFC 8414 metadata (see below) |
| `POST /register` | RFC 7591 Dynamic Client Registration → returns `client_id` |
| `GET /authorize` | Redirects to the hosted consent/sign-in page with the request params |
| `POST /token` | Code→token and `refresh_token`→token exchange; returns a PAT as `access_token` |
| `POST /issue-code` | Called by the sign-in page (with the user's Supabase JWT) to mint the auth code |

**AS metadata** (`/.well-known/oauth-authorization-server`):

```json
{
  "issuer": "https://ntykytpngslkytfyuaee.supabase.co/functions/v1/oauth",
  "authorization_endpoint": "https://secondbrainmemory.com/authorize",
  "token_endpoint": "https://ntykytpngslkytfyuaee.supabase.co/functions/v1/oauth/token",
  "registration_endpoint": "https://ntykytpngslkytfyuaee.supabase.co/functions/v1/oauth/register",
  "response_types_supported": ["code"],
  "grant_types_supported": ["authorization_code", "refresh_token"],
  "code_challenge_methods_supported": ["S256"],
  "token_endpoint_auth_methods_supported": ["none"],
  "scopes_supported": ["memory.read", "memory.write", "calendar"]
}
```

> Note on paths: Supabase functions live under `/functions/v1/…`, so the `.well-known`
> docs are served from the function path, not the domain apex. That's fine — the client is
> pointed at the exact `resource_metadata` URL via the `WWW-Authenticate` header, and the
> protected-resource doc names the AS issuer explicitly.

### 3. Sign-in / consent page (`https://secondbrainmemory.com/authorize`)

Reuse the existing connect-page machinery (`mcp/website/connect/`), which already does
Supabase PKCE login with Google/Apple. The new page:

1. Parses incoming OAuth params (`client_id`, `redirect_uri`, `state`, `code_challenge`,
   `code_challenge_method`, `scope`, `resource`).
2. Signs the user in via Supabase (`supabase.auth.signInWithOAuth`), as `connect/` does.
3. Shows a short consent line ("Allow Claude to access your SecondBrain memory") and the
   Pro status.
4. Calls `POST /functions/v1/oauth/issue-code` with the Supabase session JWT + the OAuth
   params → backend validates `client_id`/`redirect_uri`, checks **Pro**, and creates a
   single-use authorization code bound to (user, client, redirect_uri, code_challenge).
5. Redirects the browser to `redirect_uri?code=…&state=…`.

Add `https://secondbrainmemory.com/authorize` to the Supabase Auth redirect allowlist
(alongside the existing `…/connect/`).

### 4. New tables (one migration, e.g. `000XX_oauth.sql`)

```sql
-- Dynamically registered clients (claude.ai, Cowork, …)
create table public.oauth_clients (
  client_id      text primary key,          -- random, public
  redirect_uris  text[] not null,
  client_name    text,
  created_at     timestamptz not null default now()
);

-- Short-lived authorization codes (hashed at rest, like device codes)
create table public.oauth_authorization_codes (
  code_hash      text primary key,          -- sha256 of the code
  client_id      text not null references public.oauth_clients(client_id) on delete cascade,
  user_id        uuid not null references auth.users(id) on delete cascade,
  redirect_uri   text not null,
  code_challenge text not null,             -- PKCE S256
  scope          text,
  resource       text,                      -- RFC 8707 audience binding
  expires_at     timestamptz not null,      -- ~60s TTL
  consumed_at    timestamptz
);

-- Refresh tokens (hashed). Access tokens reuse the existing mcp_tokens (PATs).
create table public.oauth_refresh_tokens (
  token_hash   text primary key,
  user_id      uuid not null references auth.users(id) on delete cascade,
  client_id    text not null references public.oauth_clients(client_id) on delete cascade,
  access_token_hash text,                   -- links to the current mcp_tokens row
  expires_at   timestamptz,
  revoked_at   timestamptz,
  created_at   timestamptz not null default now()
);
```

Reuse `_shared/tokens.ts` helpers: `sha256Hex`, `generatePat`, `generateDeviceCode`
(rename to a generic `randomToken`), and the existing `mcp_tokens` insert path.

### 5. `/token` endpoint behavior

- **`grant_type=authorization_code`**: look up `code_hash`, verify not expired/consumed,
  verify `redirect_uri` matches, verify PKCE (`SHA256(verifier) == code_challenge`),
  mark consumed. Then mint a PAT via `generatePat()` → insert into `mcp_tokens`
  (`agent='claude'`, `label='<client_name> (OAuth)'`, optional `expires_at` for short-lived
  access tokens), also mint a refresh token. Return:
  ```json
  { "access_token": "sbm_…", "token_type": "Bearer", "expires_in": 3600,
    "refresh_token": "sbr_…", "scope": "memory.read memory.write calendar" }
  ```
- **`grant_type=refresh_token`**: validate refresh token, rotate it, mint a fresh PAT.
- Simpler MVP option: issue a **non-expiring** PAT and **no** refresh token (clients cope).
  Costs you token hygiene; fine for a first cut.

### 6. Pro gating

Reuse `_shared/entitlements.ts::getEntitlement` + `isPro`. Check at **`/issue-code`** (so
the consent page can show the upgrade CTA) and again at **`/token`**. If not Pro, fail the
authorize step with OAuth error `access_denied` and surface `APP_UPGRADE_URL`. (The MCP
function's per-call Pro check stays as the backstop.)

---

## Security checklist

- PKCE **S256 required**; reject plain.
- **Exact** `redirect_uri` match against the registered set.
- Authorization codes: single-use, ~60s TTL, **hashed at rest** (you already hash device
  codes and PATs — same pattern).
- Bind tokens to the `resource` (RFC 8707) so a token for SecondBrain isn't replayable
  elsewhere.
- DCR: accept only `https` redirect URIs (plus the loopback exception); consider a soft
  allowlist of client names; rate-limit `/register`.
- CORS on the metadata + token endpoints (the `mcp` function's `MCP_CORS` is a template).
- Keep `verify_jwt = false` for the `oauth` function (it validates the Supabase JWT itself
  at `/issue-code`, exactly like `mcp-connect` does via `_shared/helpers.ts`).

---

## Suggested sequencing

1. **Spike (½ day):** add the two `.well-known` docs + the 401 `WWW-Authenticate` on `mcp`.
   Point Claude/Cowork at the URL and confirm it triggers the OAuth dance (it will fail at
   `/register`, but you'll see the discovery happen in logs).
2. **DCR + authorize + issue-code + token (2–3 days):** the tables, the `oauth` function,
   and the `secondbrainmemory.com/authorize` page (forked from `connect/`). Get end-to-end login
   working with a non-expiring PAT and no refresh (MVP).
3. **Hardening (1–2 days):** short-lived access tokens + refresh rotation, Pro gating UX on
   the consent page, rate limiting, and the migration decision on tokenless 401s.
4. **Verify** on a real **Cowork** session and a **claude.ai** custom connector, then on
   ChatGPT (also speaks MCP OAuth) as a bonus.

---

## Open questions for you

- **Access-token lifetime:** short-lived + refresh (best hygiene, more code) vs. reuse the
  current non-expiring PAT model (fastest)? Recommend short-lived once the MVP works.
- **Consent screen:** minimal auto-approve after login, or an explicit "Allow" button +
  scope list? (Auto-approve is smoother; explicit is more trustworthy.)
- **Tokenless 401 migration:** flip the `mcp` function to 401-on-no-token immediately, or
  keep `initialize`/`tools/list` open during a deprecation window? No current SecondBrain
  client should break (the CLI/plugin send tokens), but confirm before flipping.

---

## Files this touches (backend repo)

- `supabase/functions/mcp/index.ts` — add the 401 + `WWW-Authenticate` challenge.
- `supabase/functions/oauth/` — **new** function (metadata, register, authorize, token, issue-code).
- `supabase/functions/_shared/tokens.ts` — reuse `generatePat`, `sha256Hex`; add refresh-token helpers.
- `supabase/functions/_shared/entitlements.ts` — reuse `getEntitlement` / `isPro`.
- `supabase/migrations/000XX_oauth.sql` — **new** tables above.
- `mcp/website/authorize/` — **new** consent/sign-in page (fork of `connect/`).
- `supabase/config.toml` — register the `oauth` function (`verify_jwt = false`).
- Supabase dashboard — add `https://secondbrainmemory.com/authorize` to the Auth redirect allowlist.

Once this ships, the Claude plugin's "cloud limitation" note (and the manual-token path)
can be deleted: Cowork / claude.ai will sign in with a browser, exactly like local.
