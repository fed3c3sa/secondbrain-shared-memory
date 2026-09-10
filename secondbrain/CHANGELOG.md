# Changelog

All notable changes to the **SecondBrain Memory** plugin are documented here.
This project follows [semantic versioning](https://semver.org).

## [0.4.2] — 2026-09-10

Right menu path for ChatGPT: OpenAI moved Developer mode, and the connector is created
from the **Plugins** page.

### Changed
- **Corrected the ChatGPT setup steps everywhere.** Developer mode now lives under
  *Settings → **Security and login***, not *Settings → Apps → Advanced* (kept as an
  "older builds" note). And the connection is made from the **Plugins** page: press
  **"+"**, give it a name and description, and paste the MCP server URL — including the
  `/mcp` path — under **Connection**. There is no separate "Create custom connector"
  item any more.
- Skill, primer, READMEs, docs and the website all carry the corrected path.

## [0.4.1] — 2026-09-10

Says the true thing about ChatGPT: a plugin can't give the **chat** surface tools.

### Changed
- **Corrected the ChatGPT guidance in the skill, primer and docs.** 0.4.0 assumed the
  ChatGPT desktop app would use the plugin's MCP server once signed in. It doesn't. The
  ChatGPT **chat** surface — the desktop app's chat *and* chatgpt.com — resolves tools
  from **connectors and apps registered in the user's ChatGPT account**, never from a
  plugin installed off a git marketplace. It picks up the plugin's *skill* only, which is
  why the assistant reports it can see SecondBrain but has nothing to query it with.
- The split, now documented everywhere: **Codex** (the CLI and the Codex surface in the
  ChatGPT app) runs the plugin's MCP server after `codex mcp login secondbrain`;
  **ChatGPT chat** needs the Developer-mode **custom connector** pointed at the same URL,
  which then covers web and desktop together.
- The skill and primer now tell the assistant to **say so plainly** when it has the skill
  but no tools, instead of stalling on "the connection isn't available yet" or sending the
  user to re-enable the plugin.

### Note for later
Getting one-click memory into ChatGPT chat means submitting SecondBrain to OpenAI's plugin
directory. Published plugins carry an `.app.json` binding them to an OpenAI-issued id
(`asdk_app_…` / `connector_…`), which is what the chat surface actually resolves — see
Notion, Linear and Slack. Ids are issued by OpenAI, so this can't be done from the repo.

## [0.4.0] — 2026-09-10

Works in the **ChatGPT desktop app / Codex** too, from the same marketplace.

### Added
- **OpenAI plugin manifest** (`secondbrain/.codex-plugin/plugin.json`). ChatGPT and Codex
  already read the Claude manifest as a fallback, but only this one carries the
  `interface` block, so the plugin now shows its display name, category, logo, brand
  colour, starter prompts and website instead of "Website: not available".
- **OpenAI marketplace catalog** (`.agents/plugins/marketplace.json`) alongside the Claude
  one, with `policy.installation: AVAILABLE` and `policy.authentication: ON_INSTALL` so
  the app knows the plugin needs an account connection at install time.
- **Plugin assets** (`secondbrain/assets/`) for the icon and light/dark logos, since
  manifest asset paths must resolve inside the plugin.

### Changed
- **`.mcp.json` now declares `oauth_resource`**, matching OpenAI's own official plugins
  (Notion, Linear, Figma). It marks the endpoint as OAuth-protected in the manifest
  itself, rather than leaving the client to discover it by probing. Claude Code ignores
  the extra key — `claude plugin validate --strict` still passes and the Claude flow is
  untouched.
- **Skill, primer and docs now name the missing step on ChatGPT/Codex.** Installing the
  plugin registers the `secondbrain` MCP server but leaves it **signed out**, which is
  why the memory tools never appeared and no login was ever offered. The one-time fix is
  `codex mcp login secondbrain`; `codex mcp list` must then read `Auth: OAuth`.
- Documented that **chatgpt.com** (the web chat surface) takes its tools from a
  **connector**, not from a locally installed plugin: Settings → Apps → Advanced →
  Developer mode → custom connector → same MCP URL → OAuth.

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
