#!/usr/bin/env bash
# Probe each model in MODELS.md with a one-token prompt and report which answer.
# Usage: scripts/probe-models.sh
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHAIN_FILE="$ROOT/MODELS.md"

if ! command -v opencode >/dev/null 2>&1; then
  echo "opencode CLI not found" >&2
  exit 1
fi
if [ ! -f "$CHAIN_FILE" ]; then
  echo "MODELS.md not found at $CHAIN_FILE" >&2
  exit 1
fi

# Pull bare ids from the numbered list, skip the "known dead" section.
mapfile -t MODELS < <(
  awk '/^## Quality-first order/{f=1;next} /^## Known dead/{f=0} f' "$CHAIN_FILE" \
    | grep -oE '`[^`]+`' | tr -d '`' | awk '!seen[$0]++'
)

if [ "${#MODELS[@]}" -eq 0 ]; then
  echo "no model ids parsed from MODELS.md" >&2
  exit 1
fi

pass=0
fail=0
printf '%-48s %s\n' "MODEL" "RESULT"
printf '%s\n' "------------------------------------------------------------------------"

for m in "${MODELS[@]}"; do
  if out="$(timeout 60 opencode run --model "$m" "reply with the single word: ok" 2>&1)"; then
    printf '%-48s %s\n' "$m" "OK"
    pass=$((pass + 1))
  else
    printf '%-48s %s\n' "$m" "FAIL"
    printf '    %s\n' "$(printf '%s' "$out" | tail -2 | tr '\n' ' ')"
    fail=$((fail + 1))
  fi
done

printf '%s\n' "------------------------------------------------------------------------"
printf 'pass=%d fail=%d\n' "$pass" "$fail"
[ "$fail" -eq 0 ]
