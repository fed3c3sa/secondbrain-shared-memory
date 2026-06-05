# Connect any other client to SecondBrain

SecondBrain is a standard **remote MCP server**. Any assistant that supports MCP can connect using two values:

- **URL:** `https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp`
- **Header:** `Authorization: Bearer YOUR_TOKEN`

Get `YOUR_TOKEN` here → [How to get your token](manual-setup.md#how-to-get-your-token).

There are two shapes of config depending on what the client supports:

- **Remote HTTP** (the native way) - give it the URL + header directly.
- **stdio bridge** (works everywhere) - wrap the remote server with `mcp-remote`:
  ```bash
  npx -y mcp-remote https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp \
    --header "Authorization: Bearer YOUR_TOKEN"
  ```

---

## VS Code (GitHub Copilot - agent mode)

VS Code supports MCP servers. Create **`.vscode/mcp.json`** in your workspace (or add via the Command Palette → **MCP: Add Server**):

```json
{
  "servers": {
    "secondbrain": {
      "type": "http",
      "url": "https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp",
      "headers": { "Authorization": "Bearer YOUR_TOKEN" }
    }
  }
}
```

Then open the **Chat** view, switch to **Agent** mode, and the SecondBrain tools appear in the tools list. (Note: the VS Code key is `servers`, not `mcpServers`.)

---

## Windsurf

Edit **`~/.codeium/windsurf/mcp_config.json`** (or use **Settings → Cascade → MCP Servers → Add**). The bridge form works on every version:

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

Then click **Refresh** in the MCP panel.

---

## Gemini CLI

Edit **`~/.gemini/settings.json`**. Gemini CLI supports remote HTTP servers via `httpUrl`:

```json
{
  "mcpServers": {
    "secondbrain": {
      "httpUrl": "https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp",
      "headers": { "Authorization": "Bearer YOUR_TOKEN" }
    }
  }
}
```

If your version doesn't support `httpUrl`, use the `mcp-remote` bridge form instead (`"command": "npx", "args": ["-y","mcp-remote", "<url>", "--header", "Authorization: Bearer YOUR_TOKEN"]`). Run `/mcp` inside Gemini CLI to confirm it connected.

---

## ChatGPT

ChatGPT supports MCP through **connectors / Developer mode** on eligible paid plans (Plus / Pro / Business / Enterprise). In **Settings → Connectors**, add a custom MCP server and paste the **URL** above.

> ⚠️ Honest note: ChatGPT's connector UI is evolving and its support for a custom `Authorization: Bearer` header varies by plan and rollout. If the UI lets you set a custom header, use the URL + `Authorization: Bearer YOUR_TOKEN`. If it only offers OAuth or no-auth connectors, header-token auth may not be available there yet - in that case use a client from the sections above. Claude, Cursor, VS Code, Windsurf, and Gemini CLI all support it today.

---

## Any other MCP client (generic recipe)

1. **Remote HTTP supported?** Point it at the URL and add header `Authorization: Bearer YOUR_TOKEN`. The transport is **Streamable HTTP** (JSON-RPC 2.0 over POST).
2. **stdio only?** Configure the command:
   ```
   command: npx
   args:    -y  mcp-remote  https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp  --header  "Authorization: Bearer YOUR_TOKEN"
   ```
3. Restart/refresh the client, then check its MCP/tools panel for `memory_search`, `memory_save`, etc.

---

## Security reminder

Your token (`sbm_…`) grants access to your memory. Treat it like a password:

- Don't paste it into public repos, screenshots, or chats.
- Revoke any leaked token: `npx secondbrain-connect revoke <id>` (or `--all`).
