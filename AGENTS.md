# AGENTS.md — portable contract

This file is loaded by every model in this project. It travels with the repo, so switching
models in the TUI does not change the rules.

## Identity of the work

We build correct software, one phase at a time, with evidence. No claim is "done" without a
command, an exit code and its key output.

## Session start — mandatory order

1. `STATE.md` — current phase, done, next, blockers.
2. `ERRORS.md` — the error ledger.
3. `PLAN.md` — phases and features.
4. Only then read source files you actually need.

If `ERRORS.md` has an `OPEN` entry, fixing it is the task. Do not start new features on top of
an open error.

## Session end — mandatory

1. Update `STATE.md` (what changed, what is next).
2. Update `ERRORS.md` (new errors, statuses).
3. `git add -A && git commit && git push`.

That commit is the resume point. Nothing else counts as saved.

## Remote execution contract

- All heavy work runs on GitHub Actions. This device is storage-constrained.
- Budget for anything written locally: **500 MB maximum**, and prefer under 50 MB.
- Do not install toolchains locally (`apt`, `npm i -g`, `cargo install`, `pip install` of large
  packages). Use `build.yml` instead.
- Do not clone large repositories locally. Read via `gh` or the GitHub API.
- Multi-megabyte downloads must go to a runner, not here.

## Continuity contract

Long tasks are split into phases. Each phase ends with a commit. A fresh session resumes by
reading `STATE.md` instead of re-reading a transcript, which is what keeps context-window
limits from interrupting work.

For a single phase that is too large for one context window, split it further and record the
split in `STATE.md` under "Next" — precise enough that a cold agent can continue without
re-deriving decisions.

## Code standards

- Complete files only. No placeholders, no `TODO` left behind, no stubbed functions.
- Errors are values where the language allows it; exceptions are last-resort, not control flow.
- Names describe intent. `fetch_user_by_id`, not `query_db`.
- Comments explain *why*, never *what*. The code already says what.
- Tests assert behaviour and live next to the code they test.
- Dependencies pinned and minimal.
- Format and lint before commit.

## Safety

- Never commit secrets. Keys live in `.dev.vars` or `.env`, both gitignored, or in Actions secrets.
- Never force-push. Never `git reset --hard` on a shared branch. Never delete files outside this repo.
- Never run destructive commands outside this project without asking.
- Report honestly. If a check failed, say so with the output.

## Evidence format

```
STATUS=PASS|FAIL|BLOCKED
CHANGED=<files>
EVIDENCE=<command + exit code + key output>
OPEN ISSUES=<or none>
NEXT=<next concrete step>
```

A missing `STATUS` line counts as `FAIL`.
