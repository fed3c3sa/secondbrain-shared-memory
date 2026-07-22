# Troubleshooting

Quick fixes for the most common things. Most issues are solved by installing Node.js and restarting your app.

## "npx is not recognized" / "command not found"

Node.js is not installed yet, or your terminal was open before you installed it.

1. Install Node.js: [docs/install-node.md](install-node.md).
2. **Open a new terminal** and try `npx secondbrain-connect` again.

## It says I need Pro

The memory is a Pro feature. Open the **SecondBrain app**, turn on **Pro** (that is the only place to do it), then run `npx secondbrain-connect` again.

## The sign-in page did not open

The terminal shows a link, copy it into your browser and sign in there. If it still does not finish, run:

```bash
npx secondbrain-connect --port 8799
```

## Apple sign-in did not work

Use Google instead, it connects the same account:

```bash
npx secondbrain-connect --google
```

## My assistant does not remember anything

**Fully quit and reopen** the app, close the whole application, not just the window. Then try again in a new chat.

## I want to start over

```bash
npx secondbrain-connect revoke --all   # disconnect everything
npx secondbrain-connect                # connect again
```

## I installed it as a Claude plugin

See the plugin guide's troubleshooting table: [docs/plugin.md](plugin.md#troubleshooting). Quick hits: run `/reload-plugins` after installing, check the `/plugin` **Errors** tab, and if tools say `not_authenticated`, sign in with `npx secondbrain-connect` and restart.

---

Still stuck? Visit [secondbrainmemory.com](https://secondbrainmemory.com).
