# The SecondBrain Claude plugin

This repo doubles as a **Claude plugin** and a **single-plugin marketplace**. The plugin
makes SecondBrain Claude's automatic memory: it bundles the **memory skill**, an
**auto-memory primer**, and the **SecondBrain connection**. Sign-in is a one-time browser
login (OAuth) — no tokens to paste — and works in Claude Code, Cowork, and claude.ai.

- Marketplace: `fed3c3sa/secondbrain-shared-memory` (this repo)
- Plugin: `secondbrain`
- Install id: `secondbrain@secondbrain`

---

## What's inside

```
secondbrain/                      ← the plugin
├── .claude-plugin/plugin.json    ← manifest (name, version)
├── .mcp.json                     ← the SecondBrain MCP connection (token-less; OAuth at runtime)
├── skills/secondbrain-memory/    ← the memory skill (recall + save + organize + link)
│   └── SKILL.md
└── hooks/
    ├── hooks.json                ← SessionStart hook
    └── memory-primer.md          ← injected each session: "use SecondBrain as primary memory"
```

| Component | Effect |
|---|---|
| MCP server `secondbrain` | The memory tools — `memory_search`, `memory_save`, `memory_list`, `memory_link`, `calendar_create_event`, `reminder_create`, … Token-less; authenticates via browser OAuth on first use. |
| Skill `/secondbrain:secondbrain-memory` | Teaches Claude when to recall and save, how to file notes into your own folders, link related notes, and add calendar events/reminders. |
| SessionStart hook | Each new session, reminds Claude to treat SecondBrain as its **primary** long-term memory and to save durable facts automatically. ~200 tokens/session. |

The bundled connection is **token-less**. The SecondBrain MCP endpoint speaks **OAuth 2.1**
(RFC 9728/8414/7591 + PKCE), so the first time memory is used your client runs a one-time
browser sign-in (Apple/Google) and stores/refreshes the credential itself — nothing to
paste, no duplicate connection, and it works the same in Claude Code, Cowork, and
claude.ai.

It requires **SecondBrain Pro** (upgrade in the app). No API keys.

---

## Install per surface

### Claude Code · Cowork · claude.ai/code

These run the plugin system natively.

```text
/plugin marketplace add fed3c3sa/secondbrain-shared-memory
/plugin install secondbrain@secondbrain
/reload-plugins
```

Or interactively: `/plugin` → **Marketplaces** → add `fed3c3sa/secondbrain-shared-memory`
→ **Discover** → **SecondBrain Memory** → install (choose **User** scope to have it
everywhere). From a terminal, the same without the leading slash:

```bash
claude plugin marketplace add fed3c3sa/secondbrain-shared-memory
claude plugin install secondbrain@secondbrain
```

### Claude Desktop (chat app)

The desktop chat app doesn't use the `/plugin` marketplace, so install the two pieces the
"desktop way":

1. **Skill** — download
   [secondbrain-memory.zip](https://github.com/fed3c3sa/secondbrain-shared-memory/raw/main/skill/secondbrain-memory.zip),
   then **Settings → Capabilities → Skills → Upload skill**, and enable it.
2. **Connection** — add SecondBrain as a **Connector** (Settings → Connectors → add a
   custom/remote MCP at `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp`) and
   sign in via the browser, or run `npx secondbrain-connect`.

Then fully quit and reopen the app. (If you drive Claude Code *inside* the desktop app,
use the `/plugin` commands above instead.)

### From the downloadable zip (offline / no marketplace)

A prebuilt archive lives at **[`dist/secondbrain-plugin.zip`](../dist/secondbrain-plugin.zip)**
(regenerate with `bash scripts/build-plugin-zip.sh`). It contains the skill, hook, and the
token-less `.mcp.json` (no secrets).

- **Claude Code / Cowork — local file** (loads for the session; needs Claude Code v2.1.128+):

  ```bash
  claude --plugin-dir dist/secondbrain-plugin.zip
  ```

- **Claude Code / Cowork — hosted** (fetched at startup):

  ```bash
  claude --plugin-url https://github.com/fed3c3sa/secondbrain-shared-memory/raw/main/dist/secondbrain-plugin.zip
  ```

- **Claude Desktop (chat app):** its Skills uploader expects a *skill* zip, not a plugin
  zip — use [`skill/secondbrain-memory.zip`](../skill/secondbrain-memory.zip) and run
  `secondbrain-connect`.

For a permanent install, prefer the marketplace path at the top.

---

## Sign in (one browser login — no token to paste)

The bundled connection is token-less; the SecondBrain MCP endpoint speaks **OAuth 2.1**.
The first time Claude uses memory and you're not signed in, your client prompts you to
sign in:

1. Approve the SecondBrain sign-in / connector when your client offers it.
2. A browser opens — log in with **Apple or Google** (the same account as the SecondBrain
   app).
3. Done. Your client stores the credential and refreshes it automatically. Nothing to
   copy or paste.

This works the same in **Claude Code, Cowork, and claude.ai** — the OAuth server
([implemented here](cowork-oauth-plan.md)) handles dynamic client registration and the
browser flow, so cloud hosts sign in exactly like local ones. Memory requires **Pro**.

- **Fallback** (a client without MCP browser sign-in, e.g. some terminal setups): run
  `npx secondbrain-connect` — it opens the browser and stores a token in your app config.
  No Node / `npx`? See the **[Node installer guide](install-node.md)**.

> **Why a browser login at all?** The memory is your private account, so the connection
> needs your authorization. OAuth does that in the browser and hands your client a token
> it keeps for you. Your token is a secret — never paste it into a chat; Claude is
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

- The bundled `.mcp.json` is committed and contains **no secrets** — only the MCP
  endpoint URL. Auth is browser OAuth at runtime, so the `.gitignore` re-includes just
  this one file (`!secondbrain/.mcp.json`) while ignoring every other `.mcp.json`.
- `version` is pinned in both `plugin.json` and `marketplace.json`. **Bump both** on each
  release, or users won't receive the update (Claude Code keys updates off the version
  string). Record changes in [`secondbrain/CHANGELOG.md`](../secondbrain/CHANGELOG.md).
- The plugin's skill omits `allowed-tools` (so it isn't tied to a specific tool
  namespace); the standalone copy under `skill/` keeps `allowed-tools` for the
  `secondbrain-connect` setup. Keep the two `SKILL.md` bodies in sync.
- After editing anything under `secondbrain/`, rebuild the archive with
  `bash scripts/build-plugin-zip.sh` and commit the updated `dist/secondbrain-plugin.zip`.

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| `/plugin` not recognized | Update Claude Code (`claude --version`); the plugin system needs a recent build. |
| Plugin installed but skill missing | Run `/reload-plugins`, or restart. Check the `/plugin` **Errors** tab. |
| Memory tools say `not_authenticated` | Complete the browser sign-in your client prompts for (approve the SecondBrain connector / `authenticate` step). Fallback: `npx secondbrain-connect`. |
| No browser sign-in prompt appears | Trigger a memory action (e.g. ask Claude to recall something) so the client connects and offers sign-in; or add SecondBrain as a connector in your client's settings. |
| `pro_required` after sign-in | The memory is a Pro feature — open the SecondBrain app and turn on **Pro**, then retry. |
| Stale after an update | `/plugin marketplace update secondbrain` then `/reload-plugins`. |
| Want a clean slate | `rm -rf ~/.claude/plugins/cache`, restart, reinstall. |

More general help: [troubleshooting.md](troubleshooting.md).
