# The memory tools

Once connected, your assistant gets these tools from the `secondbrain` MCP server. You rarely call them by name - the assistant (guided by the [skill](../skill/secondbrain-memory/SKILL.md)) decides when to use them. They're listed here so you know what's possible.

All actions are **scoped to your account** and write into **your own** SecondBrain notes and folders - the same ones you see in the app.

## Memory

| Tool | What it does |
|------|--------------|
| **`memory_search`** | Keyword search across your whole SecondBrain. Optionally scope to a folder. Omit the query to get your most recent notes. |
| **`memory_get`** | Read the full markdown of one note by id. |
| **`memory_list`** | Browse your folder tree and recent entries - used before saving so notes land in the right existing folder. |
| **`memory_save`** | Create a note (title, content, summary) in a folder of your tree. Can link related notes at save time. |
| **`memory_update`** | Edit an existing note in place (title / content / summary). |
| **`memory_link`** | Connect notes with tappable `secondbrain://note/{id}` cross-links (bidirectional, across folders). |
| **`memory_delete`** | Delete a note - only after you confirm. |

## Calendar & reminders

| Tool | What it does |
|------|--------------|
| **`calendar_create_event`** | Create a calendar event with a start **and** end time (meeting, call, flight, appointment). Uses ISO 8601 with your timezone offset. |
| **`reminder_create`** | Create a single-time reminder ("remind me to …"). |
| **`calendar_search`** | Search your events and reminders by date range or keywords. |

These show up in the **SecondBrain app** alongside your notes.

## Auth

| Tool | What it does |
|------|--------------|
| **`secondbrain_login`** | In-chat sign-in fallback. If an assistant hits the server without a valid token, it can walk you through signing in (shares a link, you sign in on the web, it finishes). The `npx secondbrain-connect` flow is smoother, but this works when you can't use a terminal. |

---

## How memory stays organized

- Notes are saved into **your existing folder tree** (the assistant reuses fitting folders rather than dumping everything in one place).
- Folders use a dot path, e.g. `root.work.projects` - created automatically if missing.
- Related notes get **linked** so your knowledge is a graph, not a pile.
- Everything is editable in the app, and shared across every assistant you connect.

See the behavior the assistant follows in [`skill/secondbrain-memory/SKILL.md`](../skill/secondbrain-memory/SKILL.md).
