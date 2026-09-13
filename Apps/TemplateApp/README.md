# TemplateApp

Gold-master iOS app for scaffolding new consumer repos.

## What it includes

- SwiftUI app (iPhone, iOS 18+)
- Local `OverloadKit` package dependency (rewritten to git URL when scaffolded)
- One unit test
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
