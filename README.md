<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/brain-icon-light.png">
  <img alt="SecondBrain" src="assets/brain-icon-dark.png" width="92">
</picture>

# SecondBrain: one memory for all your AI

**The first shared memory for AI.** Claude, Claude Code, ChatGPT, Gemini, and your open-source agents all read and write *one* memory: what any of them saves, the others instantly see, and so can you, from the phone app, anywhere.

**Your AI forgets everything the moment you close the chat. SecondBrain gives it a memory.**

Tell it something once, and every assistant you use remembers it, in the next chat and next month.

[🇬🇧 English](README.md) · [🇮🇹 Italiano](README.it.md) · [secondbrainmemory.com](https://secondbrainmemory.com)

<br>

<img src="assets/secondbrain-flow.png" alt="Your AI assistants remember and recall through one shared SecondBrain memory" width="780">

</div>

---

## What is it?

Normally your AI starts from zero every conversation: you re-explain who you are, what you're working on, your preferences, again and again.

**SecondBrain is a shared memory for your assistants.** Tell it once and it stays: your assistant remembers tomorrow, next week, and even if you switch to a different AI app. The memory is simply your own notes in the SecondBrain app: private, yours, readable and editable any time from your phone.

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

## Connect your AI in one login

> ✅ Sign in with **Apple** or **Google**, both fully supported. Use the **same account you use in the SecondBrain app**, so your assistant finds your notes.

Two steps, once:

1. **Get the app and turn on Pro** at [secondbrainmemory.com](https://secondbrainmemory.com). The memory is a Pro feature.
2. **Connect your assistant**. Find your app below. You sign in **once in your browser**; after that your AI remembers, everywhere, for good.

### Using Claude Code?

Three commands in your terminal. Run them one at a time:

```bash
claude plugin marketplace add fed3c3sa/secondbrain-shared-memory
claude plugin install secondbrain@secondbrain --scope user
npx secondbrain-connect
```

The last command opens your browser. Click **Continue with Apple** or **Continue with Google**, using the same account as the SecondBrain app. That is the only thing you do by hand. You never copy a token, a link, or any JSON.

Then fully quit Claude Code and open it again.

**Even easier:** ask Claude Code to do it for you. Paste this into the chat:

> *Install the SecondBrain plugin from https://github.com/fed3c3sa/secondbrain-shared-memory*

It knows these commands and runs them itself.

**On Windows:** the same three commands work in PowerShell or CMD. If you see `npx is not recognized`, install [Node.js](docs/install-node.md), open a **new** terminal, and run the last command again.

#### Check it worked

```bash
claude mcp get secondbrain
```

You want to see `Status: ✔ Connected`. To check the plugin too:

```bash
claude plugin list
```

`secondbrain` should be in the list. If it is listed but switched off, run `claude plugin enable secondbrain@secondbrain`.

#### What you just did

- **Marketplace:** told Claude Code where to find the plugin.
- **Plugin:** installed the memory skill, plus a note that reminds Claude to use it on its own.
- **`npx secondbrain-connect`:** signed you in and wrote the connection into Claude Code, Claude Desktop and Cursor for you.
- **Access token:** created and saved for you. You never see it or type it.

### Using ChatGPT?

Do this on **chatgpt.com in a browser**, once. It then works in the ChatGPT desktop app
too, because the connection belongs to your ChatGPT account. Needs a paid ChatGPT plan.

1. **Settings → Security and login → Developer mode**, turn it on. (Older builds put it
   under **Settings → Apps → Advanced**.)
2. Go to **Plugins** and press **"+"**. Name it `SecondBrain`, give it any description,
   and under **Connection** enter the MCP server URL:
   `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp`
3. Create the connection, then **Connect** and log in with **Apple or Google**, same
   account as the SecondBrain app. ChatGPT lists the 12 memory tools when it's done.

Then fully quit and reopen ChatGPT.

> **Why not the plugin?** ChatGPT's chat gets its tools from *connectors* in your account,
> not from a plugin installed off a marketplace. Installing our plugin in ChatGPT gives it
> the memory *skill*, but no memory tools — the assistant will say it can see SecondBrain
> but has nothing to query it with. The connector above is what actually connects it.

**Using Codex** (the `codex` CLI, or the Codex side of the ChatGPT app)? That one *does*
run the plugin, from the same marketplace as Claude:

```bash
codex plugin marketplace add fed3c3sa/secondbrain-shared-memory
codex plugin add secondbrain@secondbrain
codex mcp login secondbrain
```

The last command opens your browser for the Apple/Google login. **Don't skip it** — the
first two install the plugin but leave the memory *signed out*. Check with
`codex mcp list`: the `secondbrain` row must say `Auth: OAuth`.

### Using Cowork or Claude Desktop?

1. Download **[secondbrain-plugin.zip](https://github.com/fed3c3sa/secondbrain-shared-memory/raw/main/dist/secondbrain-plugin.zip)** (from the [`dist/`](dist/) folder).
2. Import it in the app.
3. Sign in once: **Settings → Connectors → SecondBrain → Connect** (on Cowork: **Customize → Connectors**) → log in with **Apple or Google**.

### Using anything else? One command

For Cursor, Gemini and other apps, run this once (it needs [Node.js](docs/install-node.md)), sign in with Apple or Google in the browser, then restart the app:

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
- **Saw `Dynamic Client Registration rejected (HTTP 404)`?** That comes from Claude Code's own sign-in button, and it is our bug, not something you did wrong. Run `npx secondbrain-connect` instead, then restart Claude Code. That command does not use the sign-in button at all. A proper fix is on the way.
- **ChatGPT says it can see SecondBrain but has no tool to query it?** That's the plugin without the connector. ChatGPT's chat only gets tools from connectors — add the custom connector above, then restart ChatGPT.
- **Installed it in Codex and nothing happened?** The plugin installs the memory but doesn't sign it in. Run `codex mcp login secondbrain`, check `codex mcp list` says `Auth: OAuth`, and restart.
- **Tools say `not_authenticated`?** Run `npx secondbrain-connect`, then fully quit and reopen the app.
- **Sign-in didn't open?** Try `npx secondbrain-connect --google`, or copy the link it prints into your browser.
- **`npx` not found?** Install Node.js ([guide](docs/install-node.md)), then open a new terminal.
- **Doesn't remember?** Fully quit and reopen the app (and on Claude web, make sure the SecondBrain connector shows **Connected**).

More fixes: **[Troubleshooting](docs/troubleshooting.md)**.

---

## Common questions

**Is it free?** The app is free. The shared memory is part of Pro.

**Is my data private?** Yes, the memory is your own notes in your account. Only the assistant you connect can use it, and you can disconnect any time.

**Which login can I use?** Apple or Google, both work everywhere. Just use the same one you signed up with in the SecondBrain app.

**Do I sign in every time?** No. One browser login, then it just works.

---

## Advanced

- **Claude plugin: full guide** (per-app sign-in, offline zip, troubleshooting): [docs/plugin.md](docs/plugin.md)
- **Add the connection by hand** (any remote-MCP app): point it at `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp` (transport `http`) and sign in in the browser when prompted.
- **Install just the skill** (without the plugin): drop [`skill/secondbrain-memory/SKILL.md`](skill/secondbrain-memory/SKILL.md) into your tool's skills folder (e.g. `~/.claude/skills/`), or upload [secondbrain-memory.zip](https://github.com/fed3c3sa/secondbrain-shared-memory/raw/main/skill/secondbrain-memory.zip) in Claude Desktop (**Settings → Capabilities → Skills**).

---

<div align="center">

Made with 🧠 by **SecondBrain** · [secondbrainmemory.com](https://secondbrainmemory.com)

</div>
