# STATE.md

> Read this first in every session. Update it last before every commit.

**Last updated:** 2026-11-03 (UTC)

## Current phase

P0 — Bootstrap. Repository created, files written, workflows registered.

## Done

- [x] Repo created and pushed
- [x] `AGENTS.md` contract written
- [x] `STATE.md` / `PLAN.md` / `ERRORS.md` templates in place
- [x] `opencode.json` with real model IDs from this account
- [x] `build.yml` — stack-selectable remote build
- [x] `agent-run.yml` — headless agent run producing a PR
- [x] `scripts/start-session.sh`

## In progress

Nothing.

## Next

1. Owner adds `OPENCODE_API_KEY` (or a provider key) in **Settings → Secrets and variables →
   Actions**. Required for `agent-run.yml` only.
2. Trigger a first smoke run: `gh workflow run build.yml -f stack=none`
3. Confirm the artifact uploads and the run is green.

## Blockers

- `agent-run.yml` cannot run until a provider secret exists. `build.yml` has no such dependency.

## Notes for the next session

- `opencode models` currently fails with `Location plugins did not finish activating` on the
  local device. Model IDs were taken from `~/.config/opencode/chains.conf` instead. Do not
  re-derive them from `opencode models` until that is fixed.
- Local disk: ~84% used. Keep local writes small.
