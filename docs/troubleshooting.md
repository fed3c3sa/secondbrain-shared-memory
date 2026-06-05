# Troubleshooting

## `npx: command not found` / `node is not recognized`

Node.js isn't installed, or your terminal was open before you installed it.

1. Install Node.js → [docs/install-node.md](install-node.md).
2. **Open a new terminal** and run `node -v`. It must print `v18` or higher.

---

## The sign-in browser tab didn't open

The terminal prints the sign-in URL — copy it into your browser by hand.

If the page loads but the terminal never finishes, the loopback port may be blocked or in use:
```bash
npx secondbrain-connect --port 8799
```
(Pick any free port.)

---

## "pro_required" — it says I need Pro

The shared memory is a **Pro** feature. Open the **SecondBrain app**, upgrade to **Pro** (that's the only place to do it), then run `npx secondbrain-connect` again.

---

## Apple sign-in fails

Use Google instead — it connects the same account and the same memory:
```bash
npx secondbrain-connect --google
```

---

## I connected, but my assistant doesn't see the memory

- **Fully quit and reopen** the app — *Quit the application*, not just close the window. (Claude Desktop especially.)
- **Claude Code:** start a brand-new session; run `claude mcp list` to confirm `secondbrain` is registered.
- **Cursor:** Settings → MCP, toggle `secondbrain` off and on.
- **Claude Desktop:** confirm Node.js is installed (the `mcp-remote` bridge needs it) and the JSON has no syntax errors (no trailing commas).

---

## 401 / "unauthorized" / tools error out

Your token is wrong or was revoked. Refresh it:
```bash
npx secondbrain-connect
```
Then restart the assistant.

---

## "Session expired" when running `status` / `revoke`

Your local sign-in expired. Just sign in again:
```bash
npx secondbrain-connect
```

---

## Claude Desktop server shows "failed"

- `node -v` must work (the bridge runs via `npx`).
- Validate the config JSON (a missing comma or brace breaks the whole file). Use the built-in **Settings → Developer → Edit Config** to reopen it.
- First launch can be slow while `npx` downloads `mcp-remote` once — give it a moment, then restart.

---

## I want to completely reset

```bash
npx secondbrain-connect revoke --all   # disable all tokens on the server
npx secondbrain-connect logout         # remove local credentials
```
Then connect fresh with `npx secondbrain-connect`.

---

## Corporate network / proxy

`npm`/`npx` honor `HTTP_PROXY` and `HTTPS_PROXY`. If downloads fail, set them (ask IT for the proxy URL):
```bash
export HTTPS_PROXY=http://proxy.example.com:8080
export HTTP_PROXY=http://proxy.example.com:8080
```
(On Windows PowerShell: `$env:HTTPS_PROXY="http://proxy.example.com:8080"`.)

---

Still stuck? Visit [secondbrain.icu](https://secondbrain.icu).
