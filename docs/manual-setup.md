# Manual setup & getting your token

Most people never need this — `npx secondbrain-connect` configures Claude Code, Claude Desktop, and Cursor automatically. Use this page if your client isn't auto-detected, or you want to wire it up by hand.

---

## The two values every client needs

| Value | What to use |
|-------|-------------|
| **Server URL** | `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp` |
| **Auth header** | `Authorization: Bearer YOUR_TOKEN` |

The URL is the same for everyone. `YOUR_TOKEN` is your personal, revocable token (`sbm_…`).

---

## How to get your token

You must be a **Pro** subscriber. The token is minted during sign-in. The cleanest way to see it:

1. Make an empty scratch folder and run the connect command with `--project`:
   ```bash
   mkdir sb-token && cd sb-token
   npx secondbrain-connect --project
   ```
2. Sign in when the browser opens.
3. Open the generated **`.mcp.json`** in that folder. It contains your URL and the header:
   ```json
   {
     "mcpServers": {
       "secondbrain": {
         "type": "http",
         "url": "https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp",
         "headers": { "Authorization": "Bearer sbm_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" }
       }
     }
   }
   ```
4. Copy the `sbm_…` value — that's `YOUR_TOKEN`. Use it in any client.

> The token also appears in the configs the CLI writes for detected clients (e.g. `~/.cursor/mcp.json`, `~/.claude.json`, or the Claude Desktop config). If a client was configured, you can read the token from there too.

Delete the scratch folder when done (the token stays valid until you revoke it).

---

## Config formats by transport

**Remote HTTP** (Claude Code, Cursor, VS Code, Gemini CLI):
```json
{
  "type": "http",
  "url": "https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp",
  "headers": { "Authorization": "Bearer YOUR_TOKEN" }
}
```

**stdio bridge** (Claude Desktop, Windsurf, any stdio-only client):
```json
{
  "command": "npx",
  "args": [
    "-y", "mcp-remote",
    "https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp",
    "--header", "Authorization: Bearer YOUR_TOKEN"
  ]
}
```

---

## Test it without a client (optional)

Use the official MCP Inspector to confirm the server and token work:

```bash
npx @modelcontextprotocol/inspector
```
Point it at the **URL** above, add the header `Authorization: Bearer YOUR_TOKEN`, then run `initialize` → `tools/list` → try a `memory_search`.

---

## Rotate / revoke

```bash
npx secondbrain-connect status        # list tokens + ids
npx secondbrain-connect revoke <id>   # revoke one
npx secondbrain-connect revoke --all  # revoke all
```
Revoking invalidates the token immediately on the server. Mint a fresh one by running `npx secondbrain-connect` again.
