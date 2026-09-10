# The SecondBrain Claude plugin

This repo doubles as a **Claude plugin** and a **single-plugin marketplace**. The plugin
makes SecondBrain Claude's automatic memory: it bundles the **memory skill**, an
**auto-memory primer**, and the **SecondBrain connection**. Sign-in is a one-time browser
login (OAuth), no tokens to paste, and works in Claude Code, Cowork, and claude.ai.

- Marketplace: `fed3c3sa/secondbrain-shared-memory` (this repo)
- Plugin: `secondbrain`
- Install id: `secondbrain@secondbrain`

---

## What's inside

```
.claude-plugin/marketplace.json   ← catalog read by Claude
.agents/plugins/marketplace.json  ← the same catalog, in OpenAI's format (ChatGPT/Codex)

secondbrain/                      ← the plugin
├── .claude-plugin/plugin.json    ← manifest for Claude (name, version)
├── .codex-plugin/plugin.json     ← manifest for ChatGPT/Codex (adds the `interface` block)
├── .mcp.json                     ← the SecondBrain MCP connection (token-less; OAuth at runtime)
├── assets/                       ← icon + light/dark logo, referenced by the manifest
├── skills/secondbrain-memory/    ← the memory skill (recall + save + organize + link)
│   └── SKILL.md
└── hooks/
    ├── hooks.json                ← SessionStart hook
    └── memory-primer.md          ← injected each session: "use SecondBrain as primary memory"
```

Both runtimes read one plugin. Claude uses `.claude-plugin/`, ChatGPT/Codex prefer
`.codex-plugin/` and `.agents/plugins/marketplace.json` and fall back to the Claude files
when they're absent. The skill, the hook and `.mcp.json` are shared, so there is one
source of truth and no duplicated content.

| Component | Effect |
|---|---|
| MCP server `secondbrain` | The memory tools: `memory_search`, `memory_save`, `memory_list`, `memory_link`, `calendar_create_event`, `reminder_create`, … Token-less; authenticates via browser OAuth on first use. |
| Skill `/secondbrain:secondbrain-memory` | Teaches Claude when to recall and save, how to file notes into your own folders, link related notes, and add calendar events/reminders. |
| SessionStart hook | Each new session, reminds Claude to treat SecondBrain as its **primary** long-term memory and to save durable facts automatically. ~200 tokens/session. |

The bundled connection is **token-less**. The SecondBrain MCP endpoint speaks **OAuth 2.1**
(RFC 9728/8414/7591 + PKCE), so the first time memory is used your client runs a one-time
browser sign-in (Apple/Google) and stores/refreshes the credential itself, nothing to
paste, no duplicate connection, and it works the same in Claude Code, Cowork, and
claude.ai.

It requires **SecondBrain Pro** (upgrade in the app). No API keys.

---

## Install per surface

### Claude Code · Cowork · claude.ai/code

These run the plugin system natively.

**Easiest: just ask Claude.** Say *"install SecondBrain memory"* and it does the whole
thing itself: marketplace, plugin, and sign-in, with nothing for you to copy or paste.
The skill instructs it to run the commands below on your behalf, verify with
`claude plugin list` / `claude mcp get secondbrain`, and recover on its own if a step
fails. All you do is click **Apple/Google** in the browser window that opens.

Doing it by hand instead, from a terminal (macOS, Windows, and Linux alike):

```bash
claude plugin marketplace add fed3c3sa/secondbrain-shared-memory
claude plugin install secondbrain@secondbrain --scope user
npx secondbrain-connect
```

`--scope user` installs it for every project (`project` or `local` limit it to the
current repo). The VS Code extension and the terminal CLI share one config, so
installing once covers both. Restart Claude Code afterwards, because the skill and the session
hook load in a new session.

On **Windows** the same three commands work in PowerShell or CMD. If `npx` is not
recognised, install Node ([guide](install-node.md)) and open a new terminal.

Check it worked:

```bash
claude mcp get secondbrain   # want: Status: ✔ Connected
claude plugin list           # want: secondbrain in the list
```

If the plugin is listed but switched off, run
`claude plugin enable secondbrain@secondbrain`.

The same from inside a session, as slash commands:

```text
/plugin marketplace add fed3c3sa/secondbrain-shared-memory
/plugin install secondbrain@secondbrain
/reload-plugins
```

Or interactively: `/plugin` → **Marketplaces** → add `fed3c3sa/secondbrain-shared-memory`
→ **Discover** → **SecondBrain Memory** → install (choose **User** scope to have it
everywhere).

### Which ChatGPT surface gets what

ChatGPT has two surfaces and they consume different things:

| Surface | Skill from the plugin | MCP tools from the plugin |
|---|---|---|
| **Codex** — the CLI, and the Codex surface in the ChatGPT app | yes | yes, after `codex mcp login secondbrain` |
| **ChatGPT chat** — the desktop app's chat *and* chatgpt.com | yes | **no** |

The chat surface resolves tools from **connectors and apps registered in the user's
ChatGPT account**, not from a plugin installed off a git marketplace. You can see this in
OpenAI's own catalog: every plugin whose tools work in chat ships an `.app.json` binding
it to an OpenAI-issued id (`asdk_app_…` / `connector_…`) — Notion, Linear, Slack, GitHub.
The ones with only a `.mcp.json` and no `.app.json`, like Cloudflare, are Codex-only, and
that is the category SecondBrain is in.

Those ids are issued by OpenAI, so they can't be minted from this repo. The two ways to
get memory into ChatGPT chat are therefore: a **custom connector** (per account, works
today, below) or **submitting the plugin to the ChatGPT directory** so every user gets a
published `asdk_app_…` in one click.

### Codex — the CLI and the ChatGPT app's Codex surface

Codex runs this repo's marketplace directly. Three commands, from a terminal:

```bash
codex plugin marketplace add fed3c3sa/secondbrain-shared-memory
codex plugin add secondbrain@secondbrain
codex mcp login secondbrain
```

> **The third command is not optional.** Installing the plugin registers the
> `secondbrain` MCP server but leaves it **signed out**, and nothing in the UI asks you
> to sign in — so the memory tools never show up and the assistant reports that no
> SecondBrain integration is connected. `codex mcp login secondbrain` runs the one-time
> browser OAuth (Apple/Google) and stores the credential.

Check it worked:

```bash
codex mcp list          # the `secondbrain` row must read Auth: OAuth, not Not logged in
codex plugin list       # want: secondbrain@secondbrain — installed, enabled
```

Then fully quit and reopen ChatGPT, because the skill and the session hook load in a new
session. If `codex` isn't on `PATH`, the app ships it at
`/Applications/ChatGPT.app/Contents/Resources/codex` on macOS.

### ChatGPT chat — the custom connector

This is what gives the **chat** surface the memory tools, in the desktop app and on the
web alike. Do it once on **chatgpt.com in a browser** (needs a paid ChatGPT plan):

1. **Settings → Security and login → Developer mode**, turn it on. (Older builds: under
   **Settings → Apps → Advanced**.)
2. Go to **Plugins**, press **"+"**, give it a name and description, and under
   **Connection** enter the MCP server URL, `/mcp` path included:
   `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp`
3. Create the connection, then **Connect** and log in with Apple/Google. ChatGPT shows
   the discovered tools when it's done.

The connector belongs to the ChatGPT account, so it syncs to the desktop app — no second
setup there. It is independent of the plugin: you can have either, or both.

### Claude Desktop (chat app)

The desktop chat app runs the plugin too. Import the prebuilt archive:

1. Download
   [secondbrain-plugin.zip](https://github.com/fed3c3sa/secondbrain-shared-memory/raw/main/dist/secondbrain-plugin.zip)
   (from the [`dist/`](../dist/) folder) and **import it** in the app.
2. Sign in once: **Settings → Connectors → SecondBrain → Connect** → log in with
   Apple/Google (or run `npx secondbrain-connect`).

Then fully quit and reopen the app. (If you drive Claude Code *inside* the desktop app,
the `/plugin` commands above also work.)

### From the downloadable zip (offline / no marketplace)

A prebuilt archive lives at **[`dist/secondbrain-plugin.zip`](../dist/secondbrain-plugin.zip)**
(regenerate with `bash scripts/build-plugin-zip.sh`). It contains the skill, hook, and the
token-less `.mcp.json` (no secrets).

- **Claude Code / Cowork, local file** (loads for the session; needs Claude Code v2.1.128+):

  ```bash
  claude --plugin-dir dist/secondbrain-plugin.zip
  ```

- **Claude Code / Cowork, hosted** (fetched at startup):

  ```bash
  claude --plugin-url https://github.com/fed3c3sa/secondbrain-shared-memory/raw/main/dist/secondbrain-plugin.zip
  ```

- **Claude Desktop (chat app):** import the same plugin zip in the app, then sign in via
  **Settings → Connectors → SecondBrain → Connect**.

For a permanent install, prefer the marketplace path at the top.

---

## Sign in (one browser login, no token to paste)

The connection is token-less; the SecondBrain MCP endpoint speaks **OAuth 2.1**. You sign
in **once in the browser** (Apple/Google) and your client stores + refreshes the token
itself, nothing to paste, and it stays connected. Where you trigger that one login
depends on the surface:

**Cowork / claude.ai (web).** There is no `/mcp` command here, and don't use
`npx secondbrain-connect` (its loopback redirect can't be reached from a cloud session).
Go to **Customize → Connectors** (Team/Enterprise: **Organization settings →
Connectors**):

1. If **SecondBrain** is listed (from the plugin), press **Connect**. Otherwise press
   **"+" → Add custom connector** and enter the URL
   `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp`, then **Add**.
2. Press **Connect** → a browser opens → log in with **Apple/Google** → done.

> On the web, only the Connectors **Connect** button can store the token. The assistant
> can't paste a durable sign-in link into a web session. It's still one login, then it
> persists.

**Claude Code (terminal or VS Code extension).** Run **`npx secondbrain-connect`**, or
just ask Claude to connect you and it runs it for itself. One browser login and the
connection is written into your config. No Node? See the
**[Node installer guide](install-node.md)**.

> Prefer `secondbrain-connect` over `/mcp` / `claude mcp login secondbrain` here. Claude
> Code's bundled MCP SDK looks for the OAuth discovery documents at the **origin root**,
> which a Supabase Edge Function origin can't serve, so that path currently fails with
> `Dynamic Client Registration rejected (HTTP 404): {"error":"requested path is invalid"}`.
> A proxy on a domain we control fixes it; until then `secondbrain-connect` writes a
> header-based connection that skips discovery entirely. Cowork, claude.ai, and Desktop
> follow the server's `WWW-Authenticate` challenge instead, so they are unaffected.

**Claude Desktop (app).** **Settings → Connectors** → SecondBrain → **Connect** → log in.

The OAuth server ([implemented here](cowork-oauth-plan.md)) handles dynamic client
registration and the browser flow, so every surface signs in the same way. Memory
requires **Pro**.

> **Why a browser login at all?** The memory is your private account, so the connection
> needs your authorization. OAuth does that in the browser and hands your client a token
> it keeps for you. Your token is a secret, never paste it into a chat; Claude is
> instructed never to print it. To disconnect, remove the connector or run
> `npx secondbrain-connect revoke --all`.

---

## Manage

```text
/plugin                                   # open the manager (Installed / Marketplaces / Errors)
/plugin disable secondbrain@secondbrain   # turn off without uninstalling
/plugin enable  secondbrain@secondbrain
/plugin uninstall secondbrain@secondbrain
/plugin marketplace update secondbrain    # pull the latest version
```

Disconnect the memory itself any time with `npx secondbrain-connect revoke --all`.

---

## Develop & validate

```bash
claude plugin validate ./secondbrain --strict   # manifest + structure
claude plugin validate .            --strict     # marketplace catalog
claude --plugin-dir ./secondbrain                # load locally, no install
claude plugin details secondbrain@secondbrain    # component inventory + token cost
```

Notes for contributors:

- The bundled `.mcp.json` is committed and contains **no secrets**, only the MCP
  endpoint URL. Auth is browser OAuth at runtime, so the `.gitignore` re-includes just
  this one file (`!secondbrain/.mcp.json`) while ignoring every other `.mcp.json`.
- `version` is pinned in `.claude-plugin/plugin.json`, `.codex-plugin/plugin.json` and
  `.claude-plugin/marketplace.json`. **Bump all three** on each release, or users won't
  receive the update (both runtimes key updates off the version string). Record changes in
  [`secondbrain/CHANGELOG.md`](../secondbrain/CHANGELOG.md).
- The two marketplace catalogs must list the same plugin: `.claude-plugin/marketplace.json`
  (Claude) and `.agents/plugins/marketplace.json` (ChatGPT/Codex, with the `policy` and
  `category` fields that format requires).
- `.mcp.json` carries `oauth_resource` for ChatGPT/Codex — it marks the endpoint as
  OAuth-protected in the manifest, the way OpenAI's own Notion/Linear/Figma plugins do.
  Claude Code ignores the key; keep it in sync with `url` if the endpoint ever moves.
- The plugin's skill omits `allowed-tools` (so it isn't tied to a specific tool
  namespace); the standalone copy under `skill/` keeps `allowed-tools` for the
  `secondbrain-connect` setup. Keep the two `SKILL.md` bodies in sync.
- After editing anything under `secondbrain/`, rebuild the archive with
  `bash scripts/build-plugin-zip.sh` and commit the updated `dist/secondbrain-plugin.zip`.

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| ChatGPT chat sees the plugin but says it has no tool to query SecondBrain | Expected — chat can't get tools from a plugin. Add the custom connector (Developer mode), then restart. The plugin is still worth keeping for the skill and for Codex. |
| Codex: plugin installed, memory tools missing, no login ever offered | Run `codex mcp login secondbrain`, confirm `codex mcp list` shows `Auth: OAuth`, restart. Installing the plugin does not sign the MCP server in. |
| `/plugin` not recognized | Update Claude Code (`claude --version`); the plugin system needs a recent build. |
| Plugin installed but skill missing | Run `/reload-plugins`, or restart. Check the `/plugin` **Errors** tab. |
| Memory tools say `not_authenticated` | Claude Code: run `npx secondbrain-connect` (or ask Claude to). Cowork / claude.ai / Desktop: complete the browser sign-in your client prompts for (approve the SecondBrain connector). |
| `Dynamic Client Registration rejected (HTTP 404)` in Claude Code | Expected for now, see the note under **Sign in**. Use `npx secondbrain-connect` instead of `/mcp`; verify with `claude mcp get secondbrain`. |
| No browser sign-in prompt appears | Trigger a memory action (e.g. ask Claude to recall something) so the client connects and offers sign-in; or add SecondBrain as a connector in your client's settings. |
| `pro_required` after sign-in | The memory is a Pro feature, so open the SecondBrain app and turn on **Pro**, then retry. |
| Stale after an update | `/plugin marketplace update secondbrain` then `/reload-plugins`. |
| Want a clean slate | `rm -rf ~/.claude/plugins/cache`, restart, reinstall. |

More general help: [troubleshooting.md](troubleshooting.md).
