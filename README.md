# ios-studio

Personal iOS monorepo: shared Swift packages, app templates, and CI that gates merges.

## Layout

```text
Apps/                 # iOS apps (empty for now)
Packages/
  OverloadKit/        # shared SDK (start here)
Tools/                # scaffold scripts (later)
.github/workflows/    # CI
```

## Day-1 goal (this commit)

- [x] Tiny shared package (`OverloadKit`)
- [x] Unit tests
- [x] SwiftLint config
- [x] GitHub Actions CI on every PR (`lint` + `sdk-tests`)

**Your next click:** GitHub → Settings → Branches → protect `main` → require status checks `Lint` and `SDK Tests`.

## Local commands

```bash
cd Packages/OverloadKit
swift test

# from repo root
swiftlint lint --strict --config .swiftlint.yml
```

## Next (in order)

1. Turn on branch protection (required checks).
2. Open a PR that breaks lint — confirm it cannot merge.
3. Add `Apps/TemplateApp` that depends on `OverloadKit`.
4. Add `Tools/scaffold` + a `workflow_dispatch` Action.
5. Migrate real apps (e.g. workoutTracker) as consumers.
