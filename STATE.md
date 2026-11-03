# STATE.md

> Read this first in every session. Update it last before every commit.

**Last updated:** 2026-11-03 (UTC)

## Current phase

P0 — Bootstrap. Complete. First green runs confirmed (`stack=none` and `stack=python`).

## Done

- [x] Repo created and pushed — https://github.com/airdrops47/Dark-AI
- [x] `AGENTS.md` contract written
- [x] `STATE.md` / `PLAN.md` / `ERRORS.md` templates in place
- [x] `opencode.json` with real model IDs from this account
- [x] `build.yml` — stack-selectable remote build, green on `none` and `python`
- [x] `agent-run.yml` — headless agent run producing a PR (registered, not yet executed)
- [x] `scripts/start-session.sh`, `scripts/probe-models.sh`
- [x] `MODELS.md` chain documented
- [x] E003 fixed: caches guarded with `hashFiles`

## In progress

Nothing.

## Next

1. Owner adds `OPENCODE_API_KEY` (or `OPENROUTER_API_KEY` / `GROQ_API_KEY`) in
   **Settings → Secrets and variables → Actions**. Required for `agent-run.yml` only.
2. First agent run:
   `gh workflow run agent-run.yml -f task="summarise the repo in STATE.md" -f model=opencode/deepseek-v4.1-flash-free`
3. Confirm the PR opens and the log artifact uploads.
4. Then start P1 (model chain hardening).

## Blockers

- `agent-run.yml` cannot execute until a provider secret exists. It fails loudly by design.
- The `opencode run` auth path in CI has not been proven yet — first run will confirm whether
  the secret must be named `OPENCODE_API_KEY` or a provider-specific name.

## Notes for the next session

- `opencode models` currently fails with `Location plugins did not finish activating` on the
  local device. Model IDs were taken from `~/.config/opencode/chains.conf` instead. Do not
  re-derive them from `opencode models` until that is fixed.
- Local disk: ~84% used. Keep local writes small.
