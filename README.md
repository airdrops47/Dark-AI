# Dark-AI

A **thin-client coding environment**. Your device stays light; GitHub runners do the heavy work.

## Why

The local device has ~10% free storage. Installing toolchains (Node, Rust, JDK, Gradle) would
eat hundreds of megabytes per stack. This repo moves every build, test and long agent run to
GitHub Actions, which has its own ephemeral disk.

Local footprint: markdown + JSON only. No binaries, no toolchains, no caches.

## Start a session

```bash
scripts/start-session.sh
```

That prints the three state files, then opens OpenCode.

## Session contract

Every session, in this order:

1. Read `STATE.md` — where we are.
2. Read `ERRORS.md` — what is broken (never start new work with an OPEN error).
3. Read `PLAN.md` — what is planned.
4. Work one phase.
5. Update `STATE.md` and `ERRORS.md`, commit, push.

Any model can resume cold, because the state lives in the repo rather than in a context window.

## Remote execution

| Workflow | Purpose | Trigger |
|---|---|---|
| `build.yml` | Build + test + artifact for a chosen stack | manual, or push to `main` |
| `agent-run.yml` | Headless OpenCode agent run on a branch, opens a PR | manual only |

```bash
gh workflow run build.yml -f stack=node
gh workflow run agent-run.yml -f task="fix the login redirect bug" -f model=opencode/deepseek-v4.1-flash-free
gh run watch
```

## Layout

```
AGENTS.md            portable rules every model reads
STATE.md             current phase / done / next / blockers
PLAN.md              phases, features, definition of done
ERRORS.md            error ledger with status
opencode.json        model fallback chain + permissions
scripts/             local helper scripts
.github/workflows/   remote execution
```

## Secrets

Never in this repo. `.dev.vars` and `.env` are gitignored. Copy `.dev.vars.example` to
`.dev.vars` locally. For Actions, add keys under **Settings → Secrets and variables → Actions**.

## License

MIT.
