# ios-studio

Personal iOS factory: shared Swift packages, an app template, and Actions that scaffold new consumer repos with CI gates on this repo.

## Layout

```text
Apps/TemplateApp/     # gold-master app (copied into new repos)
Packages/OverloadKit/ # shared SDK sources
Tools/scaffold/       # creates app + GitHub repo
Package.swift         # publishes OverloadKit to consumer apps via SPM
.github/workflows/    # CI + Scaffold App
ROADMAP.md            # what to do next (first real app)
CHANGELOG.md          # kit-facing changes
```

## OverloadKit (0.2.0)

Shared building blocks intended to grow from real apps:

- `Mass` + fixed formatting
- `LayoutSpacing`
- `KeyValueStore` (`UserDefaultsStore`, `InMemoryKeyValueStore`)
- `KitLog`

## Consumer apps

New apps are **separate GitHub repos**, not folders that stay here forever.

They depend on the kit like this (XcodeGen / SPM):

```yaml
packages:
  OverloadKit:
    url: https://github.com/christianberko/ios-studio.git
    branch: main
```

## Local commands

```bash
# SDK tests
swift test

# Regenerate + open template
cd Apps/TemplateApp && xcodegen generate && open TemplateApp.xcodeproj

# Dry-run scaffold (no GitHub repo)
SCAFFOLD_DRY_RUN=1 ./Tools/scaffold/scaffold.sh HabitKit habit-kit private
```

## Scaffold via GitHub Actions

1. Create a PAT that can **create repositories** under your account.
2. Add it as repo secret **`SCAFFOLD_TOKEN`**.
3. Actions → **Scaffold App** → Run workflow.
4. Enter **app name** (e.g. `HabitKit`) and **repo name** (e.g. `habit-kit`).

Scaffolded repos ship with SwiftLint + CI. If this factory repo is private, add
**`OVERLOADKIT_TOKEN`** on the consumer repo so Actions can resolve OverloadKit.

## Branch protection

Protect `main` with required checks: **Lint**, **SDK Tests**, **TemplateApp Build**.
