# TemplateApp

Gold-master iOS app for scaffolding new consumer repos.

## What it includes

- SwiftUI app (iPhone, iOS 18+)
- Local `OverloadKit` package dependency (rewritten to git URL when scaffolded)
- Shared spacing + mass formatting demo on the home screen
- Unit tests, SwiftLint config, and a consumer CI workflow
- XcodeGen `project.yml` (source of truth for the `.xcodeproj`)

## Regenerate the Xcode project

```bash
cd Apps/TemplateApp
xcodegen generate
```

## Scaffold a new app + GitHub repo

From the repo root (requires `gh` auth that can create repos):

```bash
./Tools/scaffold/scaffold.sh HabitKit habit-kit private
```

Or run the **Scaffold App** workflow in GitHub Actions (needs `SCAFFOLD_TOKEN` secret).
