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

## Signing in (automatic — the user just logs in)

The official helper `npx secondbrain-connect` signs the user in (Apple/Google) and
**writes the access token straight into the app's config** — nothing to copy or
paste. If any tool returns `status: "not_authenticated"`, get the user connected,
then retry. Never abandon the task on this error.

Run `npx secondbrain-connect` yourself, right away — don't make the user type it. It
opens their browser for a one-time sign-in and configures this assistant (and every
other on the machine). Tell the user briefly: *"Opening your browser to sign in to
SecondBrain."* If `npx`/Node isn't installed the command fails — give them the
complete installer guide (Windows · macOS · Linux):
<https://github.com/fed3c3sa/secondbrain-shared-memory/blob/main/docs/install-node.md>,
then run `npx secondbrain-connect` again. When it finishes, have the user fully
restart the app (or reconnect the MCP servers) once, then retry.

Never print the user's access token in the chat — `secondbrain-connect` handles the
token for you. If sign-in reports `pro_required`, tell the user the memory is a Pro
feature and they should open the SecondBrain app and upgrade to Pro (the only way to
go Pro). Pass along the `upgrade_url`.

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
