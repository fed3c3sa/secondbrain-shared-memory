<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/brain-icon-light.png">
  <img alt="SecondBrain" src="assets/brain-icon-dark.png" width="92">
</picture>

# SecondBrain: one memory for all your AI

**Your AI forgets everything the moment you close the chat. SecondBrain gives it a memory.**

Tell it something once — every assistant you use remembers it, in the next chat and next month.

[🇬🇧 English](README.md) · [🇮🇹 Italiano](README.it.md) · [secondbrain.icu](https://secondbrain.icu)

<br>

<img src="assets/how-it-works.svg" alt="Your AI assistants remember and recall through one shared SecondBrain memory" width="780">

</div>

---

## What is it?

Normally your AI starts from zero every conversation — you re-explain who you are, what you're working on, your preferences, again and again.

**SecondBrain is a shared memory for your assistants.** Tell it once and it stays: your assistant remembers tomorrow, next week, and even if you switch to a different AI app. The memory is simply your own notes in the SecondBrain app — private, yours, readable and editable any time from your phone.

<div align="center">

<table>
<tr>
<td align="center" width="25%"><img src="assets/screenshots/app-chat.png" width="190" alt="Talk to it"><br><sub>Just talk to it</sub></td>
<td align="center" width="25%"><img src="assets/screenshots/app-notes.png" width="190" alt="It writes the note"><br><sub>It writes the note</sub></td>
<td align="center" width="25%"><img src="assets/screenshots/app-folders.png" width="190" alt="Filed for you"><br><sub>Filed for you</sub></td>
<td align="center" width="25%"><img src="assets/screenshots/app-calendar.png" width="190" alt="Reminders too"><br><sub>Reminders too</sub></td>
</tr>
</table>

</div>

It also handles **reminders and calendar**: ask *"remind me to call the dentist tomorrow at 10"* and it shows up in the app, next to your notes.

Get the app: **[App Store (iPhone)](https://apps.apple.com/app/id6762130376)** · **[Google Play (Android)](https://play.google.com/store/apps/details?id=app.secondbrain.android)**

---

## Connect your AI — one login

1. **Get the app and turn on Pro** — at [secondbrain.icu](https://secondbrain.icu). The memory is a Pro feature.
2. **Connect your assistant** (below). You sign in **once in your browser** with Apple/Google — after that your AI remembers, everywhere, for good.

### Using Claude? Install the plugin

In **Claude Code**, **Cowork**, or **claude.ai**:

```text
/plugin marketplace add fed3c3sa/secondbrain-shared-memory
/plugin install secondbrain@secondbrain
```

Then sign in once when prompted:

- **Claude Code:** run `/mcp` → `secondbrain` → log in.
- **Cowork / claude.ai:** open **Customize → Connectors → SecondBrain → Connect** → log in.
- **Claude Desktop:** **Settings → Connectors** → add SecondBrain → **Connect** → log in.

### Using anything else? One command

For Cursor, ChatGPT, Gemini and other apps — run this once (it needs [Node.js](docs/install-node.md)), sign in in the browser, then restart the app:

```bash
npx secondbrain-connect
```

It sets up every assistant on your computer and installs the memory skill automatically.

> **Try it:** say *"Remember my favorite color is teal."* Then, in a brand-new chat, ask *"What's my favorite color?"* If it knows, you're set. 🎉

---

## Manage it

```bash
npx secondbrain-connect status        # see what's connected
npx secondbrain-connect revoke --all  # disconnect everything
```

---

## Need help?

- **It says you need Pro?** Turn on Pro in the SecondBrain app, then try again.
- **Sign-in didn't open?** Try `npx secondbrain-connect --google`, or copy the link it prints into your browser.
- **`npx` not found?** Install Node.js — [guide](docs/install-node.md).
- **Doesn't remember?** Fully quit and reopen the app (and on Claude web, make sure the SecondBrain connector shows **Connected**).

More fixes: **[Troubleshooting](docs/troubleshooting.md)**.

---

## Common questions

**Is it free?** The app is free. The shared memory is part of Pro.

**Is my data private?** Yes — the memory is your own notes in your account. Only the assistant you connect can use it, and you can disconnect any time.

**Do I sign in every time?** No. One browser login, then it just works.

---

## Advanced

- **Claude plugin — full guide** (per-app sign-in, offline zip, troubleshooting): [docs/plugin.md](docs/plugin.md)
- **Add the connection by hand** (any remote-MCP app): point it at `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp` (transport `http`) and sign in in the browser when prompted.
- **Install just the skill** (without the plugin): drop [`skill/secondbrain-memory/SKILL.md`](skill/secondbrain-memory/SKILL.md) into your tool's skills folder (e.g. `~/.claude/skills/`), or upload [secondbrain-memory.zip](https://github.com/fed3c3sa/secondbrain-shared-memory/raw/main/skill/secondbrain-memory.zip) in Claude Desktop (**Settings → Capabilities → Skills**).

---

<div align="center">

Made with 🧠 by **SecondBrain** · [secondbrain.icu](https://secondbrain.icu)

</div>
