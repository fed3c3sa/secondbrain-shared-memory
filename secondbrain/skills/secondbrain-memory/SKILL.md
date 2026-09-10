---
name: secondbrain-memory
description: >-
  SecondBrain is the assistant's main persistent memory — use it automatically.
  Recall at the start of any task and whenever the user refers to anything prior
  ("the project", "that bug", "my preference", "like last time"). Save, without
  being asked, anything durable and reusable: decisions and why, solved problems
  and fixes, stable preferences, project/stack facts, people, plans, useful
  repos/URLs. Also put time-bound things on the calendar/reminders. Connect
  related notes across folders by default. Backed by the user's own notes via the
  SecondBrain MCP (Pro).
---

# SecondBrain memory

SecondBrain is the user's persistent memory and **this assistant's primary
long-term memory** — use it so you never start from zero across sessions, and so
durable knowledge outlives any single conversation. The tools are provided by the
`secondbrain` MCP server: `memory_search`, `memory_get`, `memory_list`,
`memory_save`, `memory_update`, `memory_link`, `memory_delete`,
`calendar_create_event`, `reminder_create`, `calendar_search`, and
`secondbrain_login`. Call them by these names (your environment may expose them
fully-qualified, e.g. `secondbrain:memory_save`); use whichever form your tools
list shows.

Use memory **proactively and automatically** — recalling and saving are part of
the normal flow of every task, not something to wait for the user to request.

## Signing in (one browser login — no token to paste)

SecondBrain authenticates with a **one-time browser sign-in** (OAuth, Apple/Google). The
client stores and refreshes the credential itself — nothing to copy or paste. Memory
requires **Pro**. Where you can run the sign-in yourself and where the user has to click
depends on the surface:

- **Claude Code (terminal or VS Code extension):** **you** run it — don't send the user
  to a settings panel and never ask them to paste anything:
  ```bash
  npx secondbrain-connect
  ```
  It opens the browser for the Apple/Google login and writes the connection plus its
  access token into the config. Verify with `claude mcp get secondbrain`, then have the
  user restart once. Prefer this over `/mcp` or `claude mcp login secondbrain`: those go
  through standalone OAuth discovery, which fails today with
  `Dynamic Client Registration rejected (HTTP 404): {"error":"requested path is invalid"}`
  — a **known server-side gap** (Claude Code's bundled MCP SDK probes the origin root,
  which a Supabase Edge Function origin cannot serve; a proxy fix is in progress), not a
  user mistake. If `npx`/Node is missing, give the user the installer guide
  (Windows · macOS · Linux):
  <https://github.com/fed3c3sa/secondbrain-shared-memory/blob/main/docs/install-node.md>,
  then run the command again yourself.
- **Cowork / claude.ai (web):** here the sign-in **is** a user UI action — there is no
  `/mcp` command and **do not** run `npx secondbrain-connect` (its sign-in redirects to a
  local-loopback address that a cloud session can't reach). The connection is a
  **Connector**. Tell the user: *Customize → Connectors* (Team/Enterprise:
  *Organization settings → Connectors*) → if **SecondBrain** is listed, press **Connect**;
  otherwise press **"+" → Add custom connector**, enter the URL
  `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp`, **Add**, then **Connect**.
  A browser opens → log in with Apple/Google → done. Then retry. These clients follow the
  server's `WWW-Authenticate` challenge, so the discovery gap above doesn't affect them.
- **Claude Desktop (app):** *Settings → Connectors* → add/connect SecondBrain (same URL),
  or run `npx secondbrain-connect`.
- **ChatGPT chat (the desktop app *and* chatgpt.com):** if you can see this skill but have
  **no `secondbrain` tools at all**, the plugin is installed and there is nothing to sign
  in to — say so plainly instead of stalling. The ChatGPT chat surface takes its tools
  from **connectors**, which live in the user's ChatGPT account; a plugin installed from a
  git marketplace can hand it a skill, but not MCP tools. Don't ask the user to re-enable
  or reinstall the plugin, and don't wait for the connection to "become available". Tell
  them, once, exactly this: on **chatgpt.com in a browser** go to
  *Settings → **Security and login** → **Developer mode*** (older builds: *Settings →
  Apps → Advanced*; needs a paid ChatGPT plan), then go to **Plugins**, press **"+"**,
  name it **SecondBrain**, and under **Connection** paste the MCP server URL
  `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp`. Create the connection, then
  **Connect** and log in with Apple/Google. It belongs to the ChatGPT account, so it then
  works in the desktop app too. Restart ChatGPT and retry.
- **Codex (the CLI, and the Codex surface in the ChatGPT app):** here the plugin's MCP
  server *is* used, but installing the plugin **does not sign it in** — that is a
  separate, one-time step, and the usual reason the memory tools are missing. **You** run
  it:
  ```bash
  codex mcp login secondbrain
  ```
  It opens the browser for the Apple/Google login and stores the OAuth credential.
  Verify with `codex mcp list` — the `secondbrain` row must read `Auth: OAuth`, not
  `Not logged in`. Then restart the session. If `codex` isn't on PATH, the ChatGPT
  desktop app ships it at `/Applications/ChatGPT.app/Contents/Resources/codex` (macOS).

Never abandon the task on an auth error, and never paste or print a token. If sign-in
reports `pro_required`, the memory is a Pro feature — have the user open the SecondBrain
app and upgrade (the only place to do it); pass along the `upgrade_url`.

## Recall (read first)

At the start of a task, and whenever the user refers to anything prior, search
before acting:

1. `memory_search` with focused keywords (omit `source` to search every folder).
   Omit `query` to see the most recent entries.
2. `memory_get` on the most relevant ids to read full content before relying on
   specifics.

Prefer recalling over asking the user to repeat themselves.

## Remember (write)

When something durable and reusable is established, save it — without being asked.

- **Coding sessions:** a solved problem plus the working fix; an architectural
  decision and *why*; project/stack facts; build / run / test commands;
  environment quirks and gotchas; useful repos, URLs, and docs.
- **General chat:** facts the user wants kept (preferences, plans, people,
  reference info) and anything they signal is worth saving.

Write a clear `title`, a one or two sentence `summary` (used for search), and a
self-contained markdown `content` that will still make sense months from now.
Capture the context, not just the answer.

**Organize into the user's own folders.** Save into the user's existing
SecondBrain structure, never a separate assistant folder. Call `memory_list`
first to see their folder tree, then set `folder_path` to the best-fitting
existing folder (reuse it; don't make near-duplicates). Create a specific new
subfolder only when nothing fits. Never silo everything under a
"claude"/assistant folder or dump at the top level.

```
memory_save(
  title: "Fix: Expo dev build white screen on launch",
  summary: "Hermes + reanimated mismatch caused a white screen; pinning reanimated fixed it.",
  folder_path: "root.projects.secondbrain",
  content: "## Symptom\n...\n## Root cause\n...\n## Fix\n...",
  links: ["<id-of-a-related-note-from-search>"]
)
```

## Connect by default

Knowledge is a graph, not a pile. Before saving, search across all folders for
related entries. When you find a genuinely related note, link them **by default**:

- pass the related ids in `memory_save(links: [...])`, or
- call `memory_link(source_id, target_ids)` afterward.

Linking is bidirectional and works across different folders. Do this proactively
without waiting for the user to ask. Links render as tappable cross-references in
the SecondBrain app.

## Schedule

When the user mentions something time-bound, also put it on their calendar (it
shows up in the SecondBrain app):

- `calendar_create_event` for things with a start AND end (meeting, call, flight,
  class, appointment).
- `reminder_create` for single-time nudges ("remind me to ...").
- `calendar_search` to check the schedule or avoid duplicates first. When the user
  asks what's on / what they have / what to remember for a day or period, you MUST
  call `calendar_search` over that range (kind left unset so both events and
  reminders come back) before answering — never answer "nothing" from memory.

Use ISO 8601 with the user's timezone offset (e.g. `2026-06-10T15:00:00+02:00`),
never UTC unless they're in UTC. Never invent a date/time. If it's vague, ask.
Link to the relevant memory with `link_note_id` when there is one.

## Hygiene

- Never save secrets, API keys, tokens, passwords, sensitive personal data,
  trivial chit-chat, or anything the user asks to keep private.
- Never print the user's SecondBrain access token (or any credential) in the chat —
  `secondbrain-connect` handles tokens for you, so you never need to show one.
- Don't duplicate: if search returns a note on the same topic, `memory_update` it
  instead of saving again.
- Only `memory_delete` after the user confirms.
- Work quietly: recall and save in the background and briefly note what you saved;
  don't ask permission for routine saves.
