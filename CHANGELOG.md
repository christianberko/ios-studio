# Changelog

All notable OverloadKit / factory changes land here.

## 0.2.0 — 2026-09-29

### OverloadKit

- Split `Mass` into its own file; add pounds initializer, `Comparable`, and fixed-point `formatted(unit:)`
- Add `MeasurementFormatting` (locale-stable number formatting used by `Mass`)
- Bump `OverloadKit.version` to `0.2.0`

### Factory

- Scaffolded apps pin OverloadKit to the current kit version (up to next minor) instead of tracking `main`
- `Release` workflow tags `v<version>` automatically when `OverloadKit.version` changes on `main`
- Scaffolded apps now include `.gitignore`, SwiftLint, and consumer CI
- Consumer CI picks any available iPhone simulator and can authenticate to a private kit via `OVERLOADKIT_TOKEN`
- TemplateApp tests exercise `Mass` formatting
- Add `ROADMAP.md`

## 0.1.0 — 2026-09-13

- Initial OverloadKit (`version`, `Mass`), TemplateApp, Scaffold App workflow, PR CI
