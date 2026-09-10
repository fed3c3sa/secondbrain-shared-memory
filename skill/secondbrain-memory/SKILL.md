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
  SecondBrain MCP (Pro). Also covers setup: when the user asks to install, add, connect,
  or fix SecondBrain memory in Claude Code, run the marketplace/plugin install and
  `npx secondbrain-connect` yourself, never asking them to copy or paste anything.
allowed-tools:
  - secondbrain:memory_search
  - secondbrain:memory_get
  - secondbrain:memory_list
  - secondbrain:memory_save
  - secondbrain:memory_update
  - secondbrain:memory_link
  - secondbrain:calendar_create_event
  - secondbrain:reminder_create
  - secondbrain:calendar_search
  - secondbrain:secondbrain_login
---

# SecondBrain memory

SecondBrain is the user's persistent memory and **this assistant's primary
long-term memory** — use it so you never start from zero across sessions, and so
durable knowledge outlives any single conversation. The tools are provided by the
`secondbrain` MCP server; always call them fully-qualified
(`secondbrain:memory_save`, etc.).

Use memory **proactively and automatically** — recalling and saving are part of
the normal flow of every task, not something to wait for the user to request.

## Install and connect (you run every command — the user pastes nothing)

**Never ask the user to copy a URL, paste JSON or a token, open a settings panel,
or type a command.** You have a terminal: install and sign in yourself, then retry
the tool call. The only thing the user does is click **Apple/Google** in the browser
window that opens. Never abandon the task on an auth error.

Do this when memory tools are missing entirely, or when any tool returns
`status: "not_authenticated"`.

### Step 1 — install the plugin (Claude Code: CLI and the VS Code extension)

Same two commands on **macOS, Windows and Linux** — the VS Code extension and the
terminal CLI share one config, so installing once covers both:

```bash
claude plugin marketplace add fed3c3sa/secondbrain-shared-memory
claude plugin install secondbrain@secondbrain --scope user
```

- `--scope user` makes it available in every project. Use `--scope project` only if
  the user explicitly wants it for this repo alone.
- **`claude: command not found`?** Don't send the user to fix their PATH — locate the
  binary yourself: `which claude` (macOS/Linux) or `Get-Command claude` / `where claude`
  (Windows PowerShell), and if that fails try `~/.local/bin/claude`. Call it by full path.
- **Verify, don't assume:** `claude plugin list` must show `secondbrain`. If it is listed
  but off, run `claude plugin enable secondbrain@secondbrain`.
- The bundled skill and session hook only load in a **new** session. Say so plainly:
  *"Installed. Restart Claude Code once and the memory loads automatically."*

### Step 2 — sign the user in

```bash
npx secondbrain-connect
```

Run it yourself, right away. It opens the browser for a one-time Apple/Google sign-in
and **writes the connection and the access token straight into the app config** for
this assistant and every other one on the machine. Tell the user only:
*"Opening your browser to sign in to SecondBrain."*

If `npx`/Node is missing the command fails. Give them the installer guide
(Windows · macOS · Linux):
<https://github.com/fed3c3sa/secondbrain-shared-memory/blob/main/docs/install-node.md>,
then run `npx secondbrain-connect` again yourself.

### Step 3 — verify, and recover without asking for anything

Check your own work with read-only commands:

```bash
claude mcp list          # secondbrain should appear and health-check as connected
claude mcp get secondbrain
```

**If the in-client browser sign-in fails** — `/mcp`, `claude mcp login secondbrain`, or
an "authenticate" prompt erroring with
`Dynamic Client Registration rejected (HTTP 404): {"error":"requested path is invalid"}`
— the connection is pointed at the **old endpoint**. That error came from Claude Code's
bundled MCP SDK looking for the OAuth discovery documents at the origin root, which a
Supabase Edge Function origin cannot serve. The memory now lives at
`https://mcp.secondbrainmemory.com/mcp`, which serves them there. It is not the user's
fault and there is nothing for them to paste. Instead:

1. Re-run `npx secondbrain-connect` yourself. It configures the connection with an
   `Authorization: Bearer` header, which bypasses OAuth discovery entirely and works today.
2. Confirm with `claude mcp get secondbrain` that the entry is present and connected.
3. Have the user fully restart the app (or reconnect the MCP servers) once, then retry
   the memory tool.

If `claude mcp get secondbrain` shows a connection with **no** auth header, that is the
plugin's token-less OAuth entry; re-running `npx secondbrain-connect` replaces it with
the authenticated one at user scope.

**Never print the user's access token in the chat** — `secondbrain-connect` handles the
token for you, so you never need to see or show one. If sign-in reports `pro_required`,
tell the user the memory is a Pro feature and they should open the SecondBrain app and
upgrade to Pro (the only way to go Pro). Pass along the `upgrade_url`.

### On Codex (the CLI, and the Codex surface in the ChatGPT app)

The same marketplace works there, with `codex` instead of `claude`:

```bash
codex plugin marketplace add fed3c3sa/secondbrain-shared-memory
codex plugin add secondbrain@secondbrain
codex mcp login secondbrain
```

The third command is the one people miss: installing the plugin registers the
`secondbrain` MCP server but leaves it **signed out**, so the memory tools never
appear. `codex mcp login secondbrain` opens the browser for the one-time
Apple/Google login. Verify with `codex mcp list` — the `secondbrain` row must read
`Auth: OAuth`, not `Not logged in` — then have the user restart the app.
If `codex` isn't on PATH, the ChatGPT desktop app ships it at
`/Applications/ChatGPT.app/Contents/Resources/codex` (macOS).

### On ChatGPT chat (the desktop app and chatgpt.com)

**A plugin cannot give this surface tools**, so there is nothing for you to run. The
ChatGPT chat surface takes its tools from **connectors** held in the user's ChatGPT
account; a plugin installed from a git marketplace contributes the skill only. If you
can see this skill but no `secondbrain` tools, say so plainly rather than asking the
user to re-enable or reinstall the plugin, or waiting for a connection to appear.

Tell them, once: on **chatgpt.com in a browser**, *Settings → **Security and login**
→ **Developer mode*** (older builds: *Settings → Apps → Advanced*; needs a paid ChatGPT
plan). Then go to **Plugins**, press **"+"**, name it **SecondBrain**, and under
**Connection** paste the MCP server URL
`https://mcp.secondbrainmemory.com/mcp`. Create the connection, then
**Connect** and log in with Apple/Google. It belongs to the ChatGPT account, so it then
works in the desktop app too. Restart ChatGPT and retry.

## Recall (read first)

At the start of a task, and whenever the user refers to anything prior, search
before acting:

1. `secondbrain:memory_search` with focused keywords (omit `source` to search
   every folder). Omit `query` to see the most recent entries.
2. `secondbrain:memory_get` on the most relevant ids to read full content before
   relying on specifics.

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
SecondBrain structure, never a separate assistant folder. Call
`secondbrain:memory_list` first to see their folder tree, then set `folder_path`
to the best-fitting existing folder (reuse it; don't make near-duplicates).
Create a specific new subfolder only when nothing fits. Never silo everything
under a "claude"/assistant folder or dump at the top level.

```
secondbrain:memory_save(
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
- call `secondbrain:memory_link(source_id, target_ids)` afterward.

Linking is bidirectional and works across different folders. Do this proactively
without waiting for the user to ask. Links render as tappable cross-references in
the SecondBrain app.

## Schedule

When the user mentions something time-bound, also put it on their calendar (it shows up
in the SecondBrain app):

- `secondbrain:calendar_create_event` for things with a start AND end (meeting, call,
  flight, class, appointment).
- `secondbrain:reminder_create` for single-time nudges ("remind me to ...").
- `secondbrain:calendar_search` to check the schedule or avoid duplicates first. When
  the user asks what's on / what they have / what to remember for a day or period, you
  MUST call it over that range (kind left unset so events and reminders both come back)
  before answering — never answer "nothing" from memory.

Use ISO 8601 with the user's timezone offset (e.g. `2026-06-10T15:00:00+02:00`), never
UTC unless they're in UTC. Never invent a date/time. If it's vague, ask. Link to the
relevant memory with `link_note_id` when there is one.

## Hygiene

- Never save secrets, API keys, tokens, passwords, sensitive personal data,
  trivial chit-chat, or anything the user asks to keep private.
- Don't duplicate: if search returns a note on the same topic, `memory_update` it
  instead of saving again.
- Only `memory_delete` after the user confirms.
- Work quietly: recall and save in the background and briefly note what you saved;
  don't ask permission for routine saves.
