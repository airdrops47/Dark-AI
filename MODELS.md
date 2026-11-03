# Model chain

`opencode.json` can only name one default. This file records the fallback order to walk when a
model is rate-limited or unavailable. It is documentation, plus the source for
`scripts/probe-models.sh`.

IDs below were taken from `~/.config/opencode/chains.conf` on 2026-11-03 because
`opencode models` was failing on this device (see `ERRORS.md` E001).

## Quality-first order

1. `opencode/deepseek-v4.1-flash-free`
2. `opencode/cat-jam-free`
3. `opencode/nemotron-3.5-lightning-free`
4. `opencode/big-pickle`
5. `opencode/mimo-v2.6-flash-free`
6. `google/models/gemini-3-flash-preview`
7. `google/models/gemini-flash-lite-latest`
8. `kilo-free/kilo-auto/free`
9. `kilo-free/cohere/north-mini-code:free`
10. `llm7/codestral-latest`

## Known dead (do not use)

- `opencode/longcat-2.5-preview-free` — HTTP 402 endpoint unavailable
- `opencode/space-bunny-free` — HTTP 400 model unavailable

## Switching models

In the TUI: `/model`. In a headless run:

```bash
opencode run -m opencode/cat-jam-free "your task"
```

Behaviour does not change between models, because the contract lives in `AGENTS.md`, which is
listed under `instructions` in `opencode.json`.
