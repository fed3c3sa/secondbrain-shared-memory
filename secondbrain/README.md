<div align="center">

# SecondBrain Memory — Claude plugin

**One persistent memory for your AI.** SecondBrain becomes Claude's main long-term
memory: it recalls what matters at the start of a task and automatically saves the
durable things — decisions, fixes, preferences, people, plans, events — backed by
your own private notes.

[secondbrain.icu](https://secondbrain.icu) · [Repository](https://github.com/fed3c3sa/secondbrain-shared-memory)

</div>

---

## What this plugin installs

| Component | What it does |
|---|---|
| **MCP connection** (`secondbrain`) | The memory tools — `memory_search`, `memory_save`, `memory_list`, `memory_link`, `calendar_create_event`, `reminder_create`, and more. Token-less: you sign in once in your browser. |
| **Memory skill** (`/secondbrain:secondbrain-memory`) | Teaches Claude *when* to recall and save, how to organize into your own folders, link related notes, and add calendar events/reminders. |
| **Auto-memory primer** (SessionStart hook) | On every new session, tells Claude to treat SecondBrain as its primary memory: recall first, save durable facts automatically. |

No API keys, no tokens to paste. The connection authenticates with a **one-time browser
sign-in (OAuth, Apple/Google)** that your client runs for you — and it works in **Claude
Code, Cowork, and claude.ai** alike. Memory requires **SecondBrain Pro**.

---

## Install (Claude Code, Cowork, claude.ai/code)

```shell
/plugin marketplace add fed3c3sa/secondbrain-shared-memory
/plugin install secondbrain@secondbrain
```

Then run `/reload-plugins` (or restart). Or use the UI: `/plugin` → **Marketplaces** →
add `fed3c3sa/secondbrain-shared-memory` → **Discover** → install **SecondBrain Memory**.

> **Sign in once — just log in.** The first time Claude uses memory, your client prompts
> you to sign in to SecondBrain in the browser (Apple/Google). Approve it, log in, done —
> the client stores and refreshes the credential itself; you never paste a token. Requires
> **Pro**. Full walkthrough: [docs/plugin.md](../docs/plugin.md#sign-in).

---

## Try it

After installing and signing in, in one session:

```
Remember that I prefer pnpm over npm for all my projects.
```

Then, in a brand-new session:

```
Which package manager do I use?
```

If Claude answers "pnpm" without you re-explaining, memory is working. 🎉 You can also
invoke the skill explicitly with `/secondbrain:secondbrain-memory`.

---

## Privacy

Your memory is your own notes in your SecondBrain account. Only your signed-in client can
use it, and you can disconnect any time (remove the connector, or
`npx secondbrain-connect revoke --all`). Claude is instructed never to store secrets,
tokens, or anything you mark private — and never to print your access token in chat.

---

## Validate / develop

```shell
claude plugin validate ./secondbrain --strict   # check the manifest + structure
claude --plugin-dir ./secondbrain                # load locally without installing
```

The bundled `.mcp.json` is intentionally committed: it contains **no secrets** — only the
SecondBrain MCP endpoint URL. Authentication happens at runtime via browser OAuth.

---

## License

**MIT** — see [LICENSE](LICENSE). The plugin, skill, hooks, and configuration in this
repository are free and open source; use, modify, and redistribute them freely.

The MIT grant does **not** extend to the SecondBrain hosted service / MCP backend, the
app, or the **SecondBrain** name and logos, which remain proprietary. Using the memory
features requires a SecondBrain account (**Pro**).
