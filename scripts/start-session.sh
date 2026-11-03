#!/usr/bin/env bash
# Boot a work session: show state, then open OpenCode.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

line() { printf '%s\n' "------------------------------------------------------------"; }

line
printf 'Dark-AI session — %s\n' "$(date -u '+%Y-%m-%d %H:%M UTC')"
line

for f in STATE.md ERRORS.md PLAN.md; do
  if [ -f "$f" ]; then
    printf '\n### %s\n' "$f"
    sed -n '1,40p' "$f"
  else
    printf '\n### %s (missing)\n' "$f"
  fi
done

line
if [ -f ERRORS.md ] && grep -q '| OPEN |' ERRORS.md; then
  printf 'OPEN errors present — fix those before new features.\n'
else
  printf 'No OPEN errors.\n'
fi
line

if command -v opencode >/dev/null 2>&1; then
  exec opencode
else
  printf 'opencode not found on PATH. State printed above.\n'
fi
