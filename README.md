<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/brain-icon-light.png">
  <img alt="SecondBrain" src="assets/brain-icon-dark.png" width="92">
</picture>

# SecondBrain - Shared Memory for any AI

**Give Claude, Cursor, ChatGPT, Gemini, and any MCP-capable assistant one shared, persistent memory - backed by your own [SecondBrain](https://secondbrain.icu) notes.**

Save a fact in one assistant, recall it in another. Stop starting from zero every session.

[Website](https://secondbrain.icu) · [Quick start](#-quick-start-2-minutes) · [Install Node](#step-1-install-nodejs) · [Per-app guides](#-connect-your-app) · [Troubleshooting](#-troubleshooting)

**🇬🇧 English** · [🇮🇹 Italiano](README.it.md)

<br>

<img src="assets/how-it-works.svg" alt="How it works: your AI assistants remember and recall through one shared SecondBrain memory" width="820">

</div>

---

## What this is

SecondBrain is your personal, persistent memory. This repo is the **end-to-end guide** (plus the ready-to-install skill) for connecting any AI assistant or coding agent to it.

Once connected, your assistant can:

- **Recall** what you told it in past sessions - across *every* assistant you connect.
- **Remember** durable facts, decisions, fixes, preferences, and project notes into *your own* SecondBrain folders.
- **Connect** related notes together, and set **calendar events / reminders** that show up in the app.

Everything runs **server-side** in your own SecondBrain. Your memories are ordinary notes in your folder tree - visible and editable in the SecondBrain app, and shared by all your assistants. A note Claude saves shows up when ChatGPT searches, and vice-versa.

> **One command sets it all up:** `npx secondbrain-connect`

<div align="center">

<table>
<tr>
<td align="center" width="25%"><img src="assets/screenshots/app-chat.png" width="200" alt="Talk to it"><br><sub><b>Just ask</b> - talk to it</sub></td>
<td align="center" width="25%"><img src="assets/screenshots/app-notes.png" width="200" alt="Perfect notes"><br><sub><b>Perfect notes</b>, structured</sub></td>
<td align="center" width="25%"><img src="assets/screenshots/app-folders.png" width="200" alt="Auto-filed"><br><sub><b>Auto-filed</b> in folders</sub></td>
<td align="center" width="25%"><img src="assets/screenshots/app-calendar.png" width="200" alt="Calendar & reminders"><br><sub><b>Calendar</b> & reminders</sub></td>
</tr>
</table>

<sub>Your memory lives in the SecondBrain app - your assistants read and write the same notes.</sub>

</div>

---

## Before you start (prerequisites)

You need two things:

1. **The SecondBrain app with a Pro subscription.** The shared memory is a **Pro** feature. Get the app and upgrade to Pro inside it - [secondbrain.icu](https://secondbrain.icu). (Pro can only be enabled in the app.)
2. **Node.js 18 or newer**, which gives you the `npm` and `npx` commands. If you don't have it yet, see [Step 1](#step-1-install-nodejs) below - it takes 2 minutes on Windows, macOS, or Linux.

That's it. You do **not** need to copy any tokens, edit JSON by hand, or be technical. The connect command does the work.

---

## ⚡ Quick start (2 minutes)

Open a **terminal** (see [how to open a terminal](docs/install-node.md#how-to-open-a-terminal) if you're not sure) and run:

```bash
npx secondbrain-connect
```

This single command will:

1. Open your browser to **sign in** (Google or Apple) - no password, no token to copy.
2. Create a **revocable access token** tied to your account.
3. **Auto-configure** every assistant it finds on your machine (Claude Code, Claude Desktop, Cursor).
4. **Install the memory skill** so Claude knows *when* to use the memory.

<div align="center">
<img src="assets/screenshots/terminal.png" width="640" alt="npx secondbrain-connect output: signs you in, configures Claude Code, Claude Desktop and Cursor, installs the skill">
</div>

Then **fully quit and reopen** your assistant (quit, don't just close the window). Done - your assistant now has memory.

> Try it: ask your assistant *"What do you remember about me?"* or tell it *"Remember that I prefer tabs over spaces"*, then ask again in a new chat.

If you don't have `npx` yet, do [Step 1](#step-1-install-nodejs) first. For a specific app, jump to [Connect your app](#-connect-your-app).

---

## Step 1: Install Node.js

`npx` ships with Node.js. Installing Node.js once gives you everything. Pick your OS.

> **Check first:** you may already have it. Run `node -v` in a terminal. If it prints `v18.x` or higher, skip to [Step 2](#step-2-connect).

<details open>
<summary><b>🪟 Windows</b></summary>

**Easiest - official installer:**
1. Go to **<https://nodejs.org/en/download>** and download the **Windows Installer (.msi)**, **LTS** version.
2. Run it and click **Next** through the wizard (defaults are fine).
3. Open a new **PowerShell** or **Command Prompt** and verify:
   ```powershell
   node -v
   npm -v
   ```

**Or with a package manager (optional):**
```powershell
winget install OpenJS.NodeJS.LTS
```
(Alternative: `choco install nodejs-lts` if you use Chocolatey.)

</details>

<details open>
<summary><b>🍎 macOS</b></summary>

**Easiest - official installer:**
1. Go to **<https://nodejs.org/en/download>** and download the **macOS Installer (.pkg)**, **LTS** version.
2. Open it and click through the installer.
3. Open **Terminal** and verify:
   ```bash
   node -v
   npm -v
   ```

**Or with Homebrew (optional):**
```bash
brew install node
```
(Don't have Homebrew? Install it from <https://brew.sh>.)

</details>

<details open>
<summary><b>🐧 Linux</b></summary>

**Recommended - nvm (works on every distro, no sudo, easy to update):**
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# close and reopen your terminal, then:
nvm install --lts
node -v
```
nvm docs: <https://github.com/nvm-sh/nvm>

**Or your distro's packages:**
```bash
# Debian / Ubuntu (may be older; nvm or NodeSource gives newer)
sudo apt update && sudo apt install -y nodejs npm

# Fedora
sudo dnf install -y nodejs

# Arch
sudo pacman -S nodejs npm
```
For the latest version on Debian/Ubuntu, use **NodeSource**: <https://github.com/nodesource/distributions>

</details>

> **Why Node?** `npx` is a tool bundled with `npm`, and `npm` ships with Node.js. There's nothing extra to install - once `node -v` works, `npx` works. Full walkthrough: [docs/install-node.md](docs/install-node.md).

---

## Step 2: Connect

In your terminal:

```bash
npx secondbrain-connect
```

- The first time, npx asks to install the package - press **Enter** to accept.
- Choose **Google** (recommended) or **Apple** when prompted, then complete the sign-in in your browser.
- When you see **"Done. Your assistant can now use SecondBrain memory."**, the setup is complete.

<div align="center">
<img src="assets/screenshots/connect-signin.png" width="300" alt="SecondBrain sign-in page: Continue with Apple or Google">
<br><sub>The sign-in page that opens in your browser.</sub>
</div>

> 💡 Not Pro yet? The command will tell you and give you an upgrade link. Upgrade in the SecondBrain app, then run it again.

---

## Step 3: Restart and verify

1. **Fully quit** your assistant (Claude Desktop, Cursor, etc.) - *quit the app, not just the window* - and reopen it. (For Claude Code in a terminal, just start a new session.)
2. Ask it something that uses memory:
   - *"Save a note: my favorite color is teal."*
   - Open a new chat: *"What's my favorite color?"*

If it remembers across chats, you're connected. 🎉

---

## 🔌 Connect your app

`npx secondbrain-connect` already configures the apps below automatically. The sections here show what it did, and how to do it **manually** if you prefer or if your app wasn't detected.

### Claude Code

**Automatic:** `npx secondbrain-connect` runs `claude mcp add` for you (user scope).

**Manual:**
```bash
claude mcp add --transport http secondbrain \
  https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp \
  --header "Authorization: Bearer YOUR_TOKEN" \
  --scope user
```
- Per-project instead of global? Use `--scope project` (writes `.mcp.json` in the repo), or run `npx secondbrain-connect --project`.
- Verify with `claude mcp list`. Start a new session to load it.

👉 Full guide: [docs/claude-code.md](docs/claude-code.md)

### Claude Desktop

**Automatic:** the connect command writes your `claude_desktop_config.json` using the `mcp-remote` bridge (Claude Desktop talks to remote servers through it).

**Manual:** open your config file and add the server:

| OS | Config file |
|----|-------------|
| Windows | `%APPDATA%\Claude\claude_desktop_config.json` |
| macOS | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| Linux | `~/.config/Claude/claude_desktop_config.json` |

```json
{
  "mcpServers": {
    "secondbrain": {
      "command": "npx",
      "args": [
        "-y", "mcp-remote",
        "https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp",
        "--header", "Authorization: Bearer YOUR_TOKEN"
      ]
    }
  }
}
```
Then **fully quit and reopen** Claude Desktop.

👉 Full guide: [docs/claude-desktop.md](docs/claude-desktop.md)

### Cursor

**Automatic:** writes `~/.cursor/mcp.json`.

**Manual** - `~/.cursor/mcp.json`:
```json
{
  "mcpServers": {
    "secondbrain": {
      "type": "http",
      "url": "https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp",
      "headers": { "Authorization": "Bearer YOUR_TOKEN" }
    }
  }
}
```
Restart Cursor (or toggle the server in **Settings → MCP**).

👉 Full guide: [docs/cursor.md](docs/cursor.md)

### Everything else (VS Code, Windsurf, Gemini CLI, ChatGPT, …)

Any client that supports **remote MCP servers** can connect with the same two values:

- **URL:** `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp`
- **Header:** `Authorization: Bearer YOUR_TOKEN`

Clients that only speak **stdio** can use the bridge:
```bash
npx -y mcp-remote https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp \
  --header "Authorization: Bearer YOUR_TOKEN"
```

👉 Per-client recipes: [docs/other-clients.md](docs/other-clients.md)

> **Where's `YOUR_TOKEN`?** See [How to get your token](docs/manual-setup.md#how-to-get-your-token) - the easiest way is `npx secondbrain-connect --project` in an empty folder, which writes a `.mcp.json` containing it.

---

## 🧠 The memory skill (for Claude)

The connect command also installs a small **skill** that teaches Claude *when* to recall and save - at the start of a task, when a decision or fix is reached, when you state a lasting preference, or when you reference something from a past session.

- **Auto-installed to:** `~/.claude/skills/secondbrain-memory/SKILL.md`
- **Manual install:** copy [`skill/secondbrain-memory/SKILL.md`](skill/secondbrain-memory/SKILL.md) from this repo into that folder.

| OS | Skill folder |
|----|--------------|
| Windows | `%USERPROFILE%\.claude\skills\secondbrain-memory\` |
| macOS / Linux | `~/.claude/skills/secondbrain-memory/` |

The skill is optional but recommended - it makes memory feel automatic instead of something you have to ask for.

---

## 🔧 Manage your connection

```bash
npx secondbrain-connect status          # list your connected tokens (id, label, last used)
npx secondbrain-connect revoke <id>     # revoke one token (see ids in `status`)
npx secondbrain-connect revoke --all    # revoke every token
npx secondbrain-connect logout          # remove local credentials on this machine
```

**Useful flags for `connect`:**

| Flag | What it does |
|------|--------------|
| `--google` / `--apple` | Pick the sign-in provider (default: Google). |
| `--project` | Write `./.mcp.json` in the current folder instead of global config. |
| `--agent <name>` | Folder to store this assistant's notes (default: `claude`). |
| `--label <text>` | A label for the token (shows up in `status`). |
| `--port <n>` | Loopback port for sign-in (default: `8788`). |

**Multiple assistants or devices?** Run `npx secondbrain-connect` on each one. Every connection mints its own revocable token, but they all point to the **same memory** - so your laptop's Claude and your desktop's Cursor share everything.

---

## 🛠️ What your assistant can do (tools)

| Tool | Purpose |
|------|---------|
| `memory_search` | Keyword search across your SecondBrain (scope to a folder optionally). |
| `memory_get` | Read the full content of one note. |
| `memory_list` | Browse your folder tree + recent notes. |
| `memory_save` | Save a new note into your existing folder tree. |
| `memory_update` | Edit a note in place. |
| `memory_link` | Connect related notes (tappable cross-links in the app). |
| `memory_delete` | Delete a note (after you confirm). |
| `calendar_create_event` | Create a calendar event (start + end). |
| `reminder_create` | Create a one-time reminder. |
| `calendar_search` | Search your events/reminders. |
| `secondbrain_login` | In-chat sign-in fallback if you didn't use the CLI. |

👉 Details: [docs/tools.md](docs/tools.md)

---

## 🔒 Privacy & security

- **Your data, your notes.** Memories are saved into your own SecondBrain folders - nothing lives in a separate silo. You see and edit everything in the app.
- **Revocable tokens.** The CLI mints an opaque token (`sbm_…`) stored only as a hash on the server, scoped **only** to the memory tools, and revocable any time with `revoke`.
- **No passwords shared.** Sign-in uses Apple/Google directly; the CLI never sees your password and only writes local MCP config files.
- **Pro re-checked every call.** Access follows your subscription.
- Local credentials live in `~/.secondbrain/credentials.json` (readable only by you).

---

## 🩹 Troubleshooting

<details>
<summary><b>"command not found: npx" / "node is not recognized"</b></summary>

Node.js isn't installed or your terminal predates the install. Do [Step 1](#step-1-install-nodejs), then **open a new terminal** and run `node -v`.
</details>

<details>
<summary><b>The browser sign-in didn't open</b></summary>

The terminal prints a URL - copy it into your browser manually. If the page can't reach the loopback port, run `npx secondbrain-connect --port 8799` (any free port).
</details>

<details>
<summary><b>"pro_required" / it says I need Pro</b></summary>

The shared memory is a Pro feature. Open the **SecondBrain app**, upgrade to **Pro** (the only place to do it), then run `npx secondbrain-connect` again.
</details>

<details>
<summary><b>Apple sign-in fails</b></summary>

Use **Google** instead: `npx secondbrain-connect --google`. It connects the same account/memory.
</details>

<details>
<summary><b>My assistant doesn't see the memory after connecting</b></summary>

**Fully quit and reopen** the app (quit the application, not just close the window). For Claude Code, start a new session. Confirm the server is listed (`claude mcp list`, or check the app's MCP settings).
</details>

<details>
<summary><b>I want to start over</b></summary>

`npx secondbrain-connect logout` (clears local creds) and `npx secondbrain-connect revoke --all` (disables tokens server-side), then connect again.
</details>

👉 More: [docs/troubleshooting.md](docs/troubleshooting.md)

---

## ❓ FAQ

**Is it free?** The app is free; the **shared memory is Pro**. Upgrade in the app.

**Which assistants are supported?** Anything that speaks MCP. First-class auto-setup for **Claude Code, Claude Desktop, and Cursor**; everything else connects with a URL + token (see [other clients](docs/other-clients.md)).

**Does my data leave SecondBrain?** No. Memories are your own notes in your account. Only the assistant you connect can read/write them, using your revocable token.

**Can I use it on more than one computer?** Yes - run `npx secondbrain-connect` on each. They share one memory.

**Do I have to use the terminal forever?** No. You run it once to connect. After that, memory just works inside your assistant.

---

## 📁 What's in this repo

```
README.md                          this guide (English)
README.it.md                       questa guida (Italiano)
skill/secondbrain-memory/SKILL.md  the Claude memory skill (ready to install)
docs/install-node.md               install Node/npm/npx (Windows · macOS · Linux)
docs/claude-code.md                full Claude Code guide
docs/claude-desktop.md             full Claude Desktop guide
docs/cursor.md                     full Cursor guide
docs/other-clients.md              VS Code · Windsurf · Gemini CLI · ChatGPT · generic
docs/manual-setup.md               get your token + manual config recipe
docs/tools.md                      the memory tools, in detail
docs/troubleshooting.md            fixes for common issues
```

---

<div align="center">

Made with 🧠 by **SecondBrain** · [secondbrain.icu](https://secondbrain.icu)

</div>
