# Roadmap

Factory plumbing is in place. The next valuable work needs **your** product call.

## Done

- [x] OverloadKit package + PR CI (lint, SDK tests, TemplateApp build)
- [x] `main` branch protection with those checks
- [x] TemplateApp gold master + Scaffold App Action
- [x] Verified scaffold (`test-sdk` / TestApp)
- [x] Kit foundation slice: units, spacing, key-value store, logging
- [x] Consumer-repo CI + SwiftLint baked into the template

## Waiting on you (when you're home)

1. **Name the first real app** (not another TestApp). Habit / health / lifting are natural fits for `Mass`.
2. Scaffold it via Actions → **Scaffold App**.
3. Open it on your Mac, resolve OverloadKit, run the simulator.
4. If `ios-studio` is private, add consumer secret **`OVERLOADKIT_TOKEN`**.
5. Build the app’s first feature and **extract only what you’d copy twice** back into OverloadKit.

## Good follow-ons after the first app exists

- Tag OverloadKit releases (`0.2.0`, …) instead of always tracking `branch: main`
- Grow kit modules from real reuse (theme, navigation shell, persistence models)
- Delete or archive `test-sdk` once you’re done poking at it
- Optional: DocC for OverloadKit once the surface stabilizes

## Explicitly not next

- Multi-package monorepo / plugin architecture
- Designing a large SDK API before an app needs it
- Second consumer app before the first one shares code through the kit
