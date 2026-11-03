# ERRORS.md

> Every error gets a row. Status is `OPEN`, `FIXED` or `DEFERRED`.
> No new phase starts while any row is `OPEN`.

| ID | Error | Status | Attempts | Root cause | Fix |
|---|---|---|---|---|---|
| E001 | `opencode models` returns `ServiceUnavailableError: Location plugins did not finish activating` | DEFERRED | 1 | Plugin activation race in the local CLI (v2.0.29) | Model IDs taken from `~/.config/opencode/chains.conf` instead. Re-check after the next CLI upgrade. |
| E002 | `du -sh /home` exceeded the 120 s command timeout | FIXED | 1 | Home tree too large to walk interactively | Not needed for this task. Disk measured with `df -h`, which is O(1). |

## Template

```
| Exxx | <what failed> | OPEN | 0 | <why> | <fix or pending> |
```

Rules:

- Attempts counts real attempts, not intentions.
- After 3 attempts on the same error: write a root-cause analysis, set status `DEFERRED`,
  and record the open question in `STATE.md` under Blockers.
- Never close a row by weakening a test or changing an expected value.
