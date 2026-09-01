# Changelog

All notable changes to the **SecondBrain Memory** plugin are documented here.
This project follows [semantic versioning](https://semver.org).

## [0.3.1] — 2026-09-01

Claude Code installs and connects itself. Nothing to copy or paste.

### Changed
- **Self-install.** The skill now carries the exact commands the assistant runs on its
  own — `claude plugin marketplace add fed3c3sa/secondbrain-shared-memory`,
  `claude plugin install secondbrain@secondbrain --scope user`, then
  `npx secondbrain-connect` — plus how to locate the `claude` binary when it isn't on
  PATH, and how to verify with `claude plugin list` / `claude mcp get secondbrain`.
  Same commands on macOS, Windows and Linux; the VS Code extension and the terminal CLI
  share one config. The user only clicks Apple/Google in the browser.
- **Honest sign-in guidance for Claude Code.** `npx secondbrain-connect` is now the
  documented path there, ahead of `/mcp` and `claude mcp login`. Claude Code's bundled
  MCP SDK performs standalone RFC 9728 discovery against the **origin root**, which a
  Supabase Edge Function origin cannot serve, so that route fails with
  `Dynamic Client Registration rejected (HTTP 404): {"error":"requested path is invalid"}`.
  `secondbrain-connect` writes a header-based connection that skips discovery entirely.
  Cowork, claude.ai and Desktop follow the server's `WWW-Authenticate` challenge and are
  unaffected — their Connector flow is unchanged.
- The skill's recovery path never asks the user to paste a token, a URL, or JSON: on
  failure the assistant re-runs `secondbrain-connect` and re-verifies by itself.

### Fixed (server side, shipped separately)
- The SecondBrain OAuth layer now serves a schema-valid OpenID Connect discovery
  document with `jwks_uri` / `subject_types_supported` /
  `id_token_signing_alg_values_supported` (plus an empty `jwks.json`), serves the
  `.well-known` documents under `/functions/v1/mcp/` too, returns the 401 OAuth
  challenge on unauthenticated `GET` as well as `POST`, and accepts private-use
  `redirect_uris` (`vscode://`, `cursor://`). The remaining origin-root gap needs a
  proxy on a domain we control.

## [0.3.0] — 2026-06-06

Browser sign-in (OAuth) — the bundled connection is back, and now it works on cloud.

### Added
- **Bundled MCP connection** (`.mcp.json`) again — but token-less. The SecondBrain
  MCP endpoint now speaks **OAuth 2.1** (RFC 9728/8414/7591 + PKCE), so adding the
  plugin gives a one-time **browser sign-in** (Apple/Google) handled by the client.
  No token to paste, durable, and it works in **Claude Code, Cowork, and claude.ai** —
  the earlier "cloud can't sign in" limitation is gone.

### Changed
- Skill, primer, and docs rewritten around browser OAuth sign-in. `secondbrain-connect`
  is now just a fallback for clients without MCP browser sign-in.
- Because the client owns the OAuth token for the bundled connection, there is no
  duplicate/competing connection like the old token-less bundle had.

## [0.2.0] — 2026-06-06

Reworked authentication around the official `secondbrain-connect` helper.

### Changed
- **Removed the bundled MCP server** (`.mcp.json`) and the `api_token` user option.
  Bundling a token-less `secondbrain` server created a *second*, unauthenticated
  connection that fought with the one `secondbrain-connect` configures, and it could
  never authenticate on its own. The plugin now ships **just the skill and the
  auto-memory hook**.
- **Sign-in is fully automatic and paste-free.** When Claude needs memory and you're
  not connected, it runs `npx secondbrain-connect` for you: one browser sign-in, and
  the token is written straight into the app config. The skill, primer, and docs were
  rewritten accordingly, including a complete Node/`npx` installer guide reference for
  Windows/macOS/Linux.
- **Never echo tokens.** The skill is now explicit: never print the access token in
  the chat (a hardening fix after an earlier flow surfaced one).

### Known limitation
- On **cloud hosts (Cowork / claude.ai)** a local CLI can't configure the session, so
  `secondbrain-connect` doesn't wire it up there. True browser sign-in for cloud is
  tracked in [docs/cowork-oauth-plan.md](../docs/cowork-oauth-plan.md) (server-side
  MCP OAuth).

## [0.1.0] — 2026-06-06

Initial release.

### Added
- **MCP connection** (`secondbrain`) to the SecondBrain memory endpoint. Token-less
  by default — sign-in happens at runtime via `npx secondbrain-connect` or the
  in-chat `secondbrain_login` device flow. Optional `userConfig.api_token` for
  always-on authentication.
- **Memory skill** (`/secondbrain:secondbrain-memory`): recall-first guidance,
  proactive saving of durable facts, folder organization into the user's own
  structure, default linking of related notes, and calendar/reminder scheduling.
- **Auto-memory primer** (SessionStart hook): injects a short reminder so Claude
  treats SecondBrain as its primary long-term memory in every session.
- Marketplace catalog (`.claude-plugin/marketplace.json`) so the plugin installs
  with `/plugin marketplace add fed3c3sa/secondbrain-shared-memory` followed by
  `/plugin install secondbrain@secondbrain`.
