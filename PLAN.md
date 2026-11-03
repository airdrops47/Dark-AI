# PLAN.md

> The plan. Phases are small on purpose. One phase per session if the phase is large.

## Goal

A free, GitHub-based coding environment that:

- keeps local storage usage near zero,
- runs all heavy builds and long agent runs on GitHub Actions,
- works with whichever model is selected in the OpenCode TUI,
- survives session interruption by keeping state in the repo,
- integrates third-party tools through MCP.

## Phases

### P0 — Bootstrap

- [x] Create repository
- [x] Portable `AGENTS.md` contract
- [x] State / plan / error ledgers
- [x] `opencode.json` with a real model chain
- [x] Remote build workflow
- [x] Remote agent workflow
- [x] Session helper script
- [x] First green smoke run

### P1 — Model chain hardening

- [ ] Verify each model in `opencode.json` fallback order actually responds
- [ ] Record working IDs in `STATE.md`
- [ ] Add a small script that probes the chain and reports dead entries

### P2 — Build matrix

- [ ] `build.yml` covers node, python, rust, go, java
- [ ] Dependency caching keyed on lockfiles
- [ ] Artifact retention tuned (7 days)

### P3 — Agent PR loop

- [ ] `agent-run.yml` opens a PR with a diff summary
- [ ] Fails loudly when no provider secret is present
- [ ] Optional `continue` input to resume the previous agent session

### P4 — Third-party integration

- [ ] MCP server config block documented
- [ ] At least one external tool wired end to end
- [ ] Secrets documented per tool

### P5 — App modification pipeline

- [ ] Document the analysis → patch → verify loop for an existing application
- [ ] Local verification is done by running the app's own test suite on a runner
- [ ] No copyrighted assets redistributed

## Feature list

1. Thin client, remote execution
2. Model-agnostic behaviour via repo-resident contract
3. Cross-session continuity from committed state
4. Manual and push-triggered remote builds
5. Headless agent runs producing reviewable PRs
6. Artifact-driven verification (logs, test reports, build output)
7. Secrets kept out of the tree
8. MCP-based third-party tool support

## Definition of done

- Every phase checkbox above is ticked.
- No `TODO`, placeholder or stub in the tree.
- `gh run list` shows green runs for both workflows.
- A cold session, given only this repo, can continue the work from `STATE.md`.
