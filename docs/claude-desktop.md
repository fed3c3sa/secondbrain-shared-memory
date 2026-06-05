# Connect Claude Desktop to SecondBrain

[Claude Desktop](https://claude.ai/download) is the Claude app for Mac and Windows. It connects to remote MCP servers through a small bridge called **`mcp-remote`** (the connect command sets this up for you).

## The easy way (recommended)

```bash
npx secondbrain-connect
```

It detects Claude Desktop and writes the correct entry into your `claude_desktop_config.json`. Then **fully quit and reopen** Claude Desktop (Quit, not just close the window).

---

## Manual setup

1. Get [your token](manual-setup.md#how-to-get-your-token).
2. Open your config file (create it if it doesn't exist):

   | OS | Path |
   |----|------|
   | **Windows** | `%APPDATA%\Claude\claude_desktop_config.json` |
   | **macOS** | `~/Library/Application Support/Claude/claude_desktop_config.json` |
   | **Linux** | `~/.config/Claude/claude_desktop_config.json` |

   > Tip (macOS/Windows): in Claude Desktop go to **Settings → Developer → Edit Config** to open this file directly.

3. Add the `secondbrain` server. If the file already has other servers, just add `secondbrain` inside the existing `mcpServers` object — don't delete the others.

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

4. Save the file and **fully quit and reopen** Claude Desktop.

> **Why `mcp-remote`?** Claude Desktop launches MCP servers as local commands (stdio). `mcp-remote` is a tiny bridge that forwards that to our remote HTTPS server with your auth header. It's fetched automatically by `npx -y` the first time — so Node.js must be installed (it is, if you ran the connect command).

---

## Verify

After reopening, click the **tools / 🔌 connector icon** in the message box — you should see SecondBrain tools (e.g. `memory_search`, `memory_save`). Try: *"Save a note that I prefer dark mode,"* then in a new chat: *"Do I prefer dark or light mode?"*

---

## Troubleshooting

- **Server shows as failed:** make sure Node.js is installed (`node -v`) — `mcp-remote` needs it. Confirm the JSON is valid (no trailing commas).
- **No tools after editing:** you must **Quit** the app fully and reopen; closing the window isn't enough.
- **401 / unauthorized:** token revoked or wrong — re-run `npx secondbrain-connect`.
- **`pro_required`:** upgrade to Pro in the SecondBrain app, then reconnect.

More: [docs/troubleshooting.md](troubleshooting.md).
