# Connect Claude Code to SecondBrain

[Claude Code](https://claude.com/claude-code) is Anthropic's CLI/agent. This is the fastest client to set up.

## The easy way (recommended)

```bash
npx secondbrain-connect
```

This signs you in, mints a token, and runs `claude mcp add` for you at **user scope** (available in every project). It also installs the memory **skill** to `~/.claude/skills/secondbrain-memory/`.

Start a **new** Claude Code session and the `secondbrain` tools are available.

Verify:
```bash
claude mcp list
```
You should see `secondbrain` listed as an `http` server.

---

## Manual setup

If you'd rather add it yourself (or the auto-setup didn't run), you need [your token](manual-setup.md#how-to-get-your-token) first, then:

### User scope (all projects)
```bash
claude mcp add --transport http secondbrain \
  https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp \
  --header "Authorization: Bearer YOUR_TOKEN" \
  --scope user
```

### Project scope (writes `.mcp.json` in the current repo, shareable with the team)
```bash
claude mcp add --transport http secondbrain \
  https://ntykytpngslkytfyuaee.supabase.co/functions/v1/mcp \
  --header "Authorization: Bearer YOUR_TOKEN" \
  --scope project
```
Or simply: `npx secondbrain-connect --project` (writes `.mcp.json` in the folder you're in).

> ⚠️ A `.mcp.json` committed to a repo contains your **token**. Don't commit it to a public repo — keep project-scope configs out of version control, or use user scope.

---

## Use it

In a Claude Code session, the memory is automatic when the skill is installed. You can also be explicit:

- *"Search my SecondBrain for the deployment runbook."*
- *"Remember: this project uses pnpm, not npm."*
- *"What did we decide about the auth flow last week?"*

---

## Manage / remove

```bash
claude mcp list                  # see configured servers
claude mcp remove secondbrain    # remove it from Claude Code
npx secondbrain-connect status   # see your tokens
npx secondbrain-connect revoke --all   # disable tokens server-side
```

## Troubleshooting

- **Tools don't appear:** start a brand-new session; run `claude mcp list` to confirm it's registered.
- **401 / unauthorized:** your token was revoked or is wrong. Re-run `npx secondbrain-connect`.
- **`pro_required`:** upgrade to Pro in the SecondBrain app, then reconnect.

More: [docs/troubleshooting.md](troubleshooting.md).
