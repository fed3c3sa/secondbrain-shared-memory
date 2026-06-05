<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/brain-icon-light.png">
  <img alt="SecondBrain" src="assets/brain-icon-dark.png" width="92">
</picture>

# SecondBrain: one memory for all your AI

**Your AI assistants forget everything the moment you close the chat. SecondBrain gives them a memory.**

Tell something once, and every assistant you use remembers it, in the next chat and next month.

[🇬🇧 English](README.md) · [🇮🇹 Italiano](README.it.md) · [secondbrain.icu](https://secondbrain.icu)

<br>

<img src="assets/how-it-works.svg" alt="Your AI assistants remember and recall through one shared SecondBrain memory" width="780">

</div>

---

## What is it?

Normally, your AI starts from zero in every new conversation. You explain who you are, what you are working on, your preferences, again and again.

**SecondBrain is a shared memory for your assistants.** You tell it something once, and it stays: your assistant remembers it tomorrow, next week, and even if you switch to a different AI app. The memory is simply your own notes in the SecondBrain app, so it is private, it is yours, and you can read or edit it any time from your phone.

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

---

## What you need

1. **The SecondBrain app, with Pro.** The memory is a Pro feature. Get the app and turn on Pro inside it: [secondbrain.icu](https://secondbrain.icu).
2. **A computer** (Windows, Mac, or Linux) to run one short command, once.

That is all. No accounts to wire up, no settings to copy. The setup below does everything for you.

---

## Setup in 3 steps

### Step 1: Install Node.js

The setup uses a free tool called **Node.js**. Installing it takes about 2 minutes and you only do it once.

- Go to **[nodejs.org/en/download](https://nodejs.org/en/download)**, download the **LTS** version for your system, and run the installer (click Next through it).
- Need a hand? Follow the simple per-system guide here: **[Install Node.js](docs/install-node.md)**.

> Already have it? You can skip this step. (If you are not sure, just continue, it will tell you.)

### Step 2: Run the connect command

Open a **terminal** on your computer:

- **Windows:** press the Windows key, type **PowerShell**, press Enter.
- **Mac:** press Cmd + Space, type **Terminal**, press Enter.
- **Linux:** open your **Terminal** app.

Type this and press Enter:

```bash
npx secondbrain-connect
```

Your browser opens. **Sign in with Google or Apple.** That is the whole setup, no passwords or codes to copy.

<div align="center">
<img src="assets/screenshots/terminal.png" width="620" alt="The connect command signs you in and sets up your assistant automatically">
<br><br>
<img src="assets/screenshots/connect-signin.png" width="280" alt="Sign in with Apple or Google">
<br><sub>The sign-in page that opens in your browser.</sub>
</div>

### Step 3: Restart your AI app

Fully **quit and reopen** your assistant (close the whole app, not just the window). Done.

> **Try it:** tell your assistant *"Remember that my favorite color is teal."* Then open a new chat and ask *"What is my favorite color?"* If it knows, the memory works. 🎉

---

## Works with

Claude (Desktop and Code), Cursor, and other AI apps. The connect command sets up everything it finds on your computer automatically. Got a new device? Just run the command there too, it is the same memory everywhere.

---

## Manage it

```bash
npx secondbrain-connect status        # see what is connected
npx secondbrain-connect revoke --all  # disconnect everything
```

---

## Need help?

- **It says you need Pro?** Open the SecondBrain app and turn on Pro (that is the only place to do it), then run the command again.
- **Apple sign-in did not work?** Use Google instead: `npx secondbrain-connect --google`.
- **`npx` not found?** Node.js is not installed yet, see [Step 1](#step-1-install-nodejs).
- **Your assistant does not remember?** Fully quit and reopen the app.

More fixes: **[Troubleshooting](docs/troubleshooting.md)**.

---

## Common questions

**Is it free?** The app is free. The shared memory is part of Pro.

**Is my data private?** Yes. The memory is your own notes in your account. Only the assistant you connect can use it, and you can disconnect any time.

**Do I have to use the terminal every day?** No. You run the command once to connect. After that, the memory just works inside your assistant.

---

<div align="center">

Made with 🧠 by **SecondBrain** · [secondbrain.icu](https://secondbrain.icu)

</div>
