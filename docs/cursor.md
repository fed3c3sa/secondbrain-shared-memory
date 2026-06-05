# Connect Cursor to SecondBrain

[Cursor](https://cursor.com) is an AI code editor with native MCP support.

## The easy way (recommended)

```bash
npx secondbrain-connect
```

It detects Cursor and writes `~/.cursor/mcp.json`. Restart Cursor (or toggle the server in **Settings → MCP**).

---

## Manual setup

1. Get [your token](manual-setup.md#how-to-get-your-token).
2. Edit (or create) **`~/.cursor/mcp.json`** for a global server, or **`.cursor/mcp.json`** inside a project for a per-project server:

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

3. Open **Cursor → Settings → MCP** (or **Cursor Settings → Tools & Integrations**) and confirm `secondbrain` is enabled (green). Toggle it off/on if it doesn't connect immediately.

> Some Cursor versions support adding an MCP server straight from the Settings UI - paste the URL and the `Authorization: Bearer YOUR_TOKEN` header there instead of editing JSON.

> ⚠️ A project-level `.cursor/mcp.json` contains your **token** - don't commit it to a public repo.

---

## Verify

In the Cursor chat (Agent mode), ask: *"Use SecondBrain to save a note that this repo uses Vite,"* then in a new chat: *"What build tool does this repo use?"*

---

## Troubleshooting

- **Server not connecting:** toggle it in Settings → MCP; make sure the JSON is valid.
- **401 / unauthorized:** re-run `npx secondbrain-connect` to refresh the token.
- **`pro_required`:** upgrade to Pro in the SecondBrain app, then reconnect.

More: [docs/troubleshooting.md](troubleshooting.md).
