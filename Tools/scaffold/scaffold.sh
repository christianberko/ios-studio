#!/usr/bin/env bash
# Scaffold a new iOS consumer app from Apps/TemplateApp and create its GitHub repo.
#
# Usage:
#   ./Tools/scaffold/scaffold.sh <AppName> <repo-name> [private|public]
#
# Example:
#   ./Tools/scaffold/scaffold.sh HabitKit habit-kit private
#
# Requires: xcodegen, gh (authenticated with repo-create permission)
set -euo pipefail

APP_NAME="${1:?AppName required (PascalCase, e.g. HabitKit)}"
REPO_NAME="${2:?repo-name required (e.g. habit-kit)}"
VISIBILITY="${3:-private}"

if [[ ! "$APP_NAME" =~ ^[A-Z][A-Za-z0-9]+$ ]]; then
  echo "error: AppName must be PascalCase alphanumeric (e.g. HabitKit)" >&2
  exit 1
fi

if [[ ! "$REPO_NAME" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
  echo "error: repo-name must be lowercase kebab-case (e.g. habit-kit)" >&2
  exit 1
fi

if [[ "$VISIBILITY" != "private" && "$VISIBILITY" != "public" ]]; then
  echo "error: visibility must be private or public" >&2
  exit 1
fi

for cmd in xcodegen gh; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "error: $cmd is required" >&2
    exit 1
  fi
done

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SRC="$ROOT/Apps/TemplateApp"
OWNER="${GITHUB_REPOSITORY_OWNER:-$(gh api user -q .login)}"
KIT_URL="https://github.com/${OWNER}/ios-studio.git"
BUNDLE_ID="com.christianberko.$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]')"

WORK="$(mktemp -d "${TMPDIR:-/tmp}/ios-studio-scaffold.XXXXXX")"
DEST="$WORK/$REPO_NAME"
trap 'rm -rf "$WORK"' EXIT

echo "→ Copying TemplateApp → $DEST"
cp -R "$SRC" "$DEST"
rm -rf "$DEST/TemplateApp.xcodeproj"
rm -f "$DEST/README.md"

echo "→ Renaming targets to $APP_NAME"
mv "$DEST/TemplateApp" "$DEST/$APP_NAME"
mv "$DEST/TemplateAppTests" "$DEST/${APP_NAME}Tests"
mv "$DEST/$APP_NAME/TemplateAppApp.swift" "$DEST/$APP_NAME/${APP_NAME}App.swift"
mv "$DEST/${APP_NAME}Tests/TemplateAppTests.swift" "$DEST/${APP_NAME}Tests/${APP_NAME}Tests.swift"

echo "→ Pointing OverloadKit at $KIT_URL (branch main)"
python3 - "$DEST/project.yml" "$KIT_URL" <<'PY'
import pathlib, re, sys
path = pathlib.Path(sys.argv[1])
kit_url = sys.argv[2]
text = path.read_text()
pattern = re.compile(
    r"packages:\n(?:  #.*\n)*  OverloadKit:\n    path: \.\./\.\.\n",
    re.MULTILINE,
)
replacement = f"""packages:
  OverloadKit:
    url: {kit_url}
    branch: main
"""
new_text, count = pattern.subn(replacement, text, count=1)
if count != 1:
    raise SystemExit("expected local OverloadKit path dependency not found in project.yml")
path.write_text(new_text)
PY

echo "→ Rewriting placeholders"
# shellcheck disable=SC2016
while IFS= read -r -d '' file; do
  perl -pi -e "s/TemplateApp/${APP_NAME}/g" "$file"
  perl -pi -e "s/com\\.christianberko\\.templateapp/${BUNDLE_ID}/g" "$file"
done < <(find "$DEST" -type f \( -name '*.swift' -o -name '*.yml' -o -name '*.md' \) -print0)

cat > "$DEST/README.md" <<EOF
# ${APP_NAME}

iOS app scaffolded from [ios-studio](${KIT_URL}) TemplateApp.

## Setup

\`\`\`bash
# Regenerate Xcode project after editing project.yml
xcodegen generate
open ${APP_NAME}.xcodeproj
\`\`\`

Depends on **OverloadKit** via SPM (\`${KIT_URL}\`, branch \`main\`).
EOF

echo "→ Generating Xcode project"
(
  cd "$DEST"
  xcodegen generate
)

if [[ "${SCAFFOLD_DRY_RUN:-}" == "1" ]]; then
  echo "SCAFFOLD_DRY_RUN=1 → skipping gh repo create"
  echo "Scaffolded at: $DEST"
  # Keep workdir for inspection
  trap - EXIT
  echo "$DEST"
  exit 0
fi

echo "→ Creating GitHub repo ${OWNER}/${REPO_NAME} (${VISIBILITY})"
(
  cd "$DEST"
  git init -b main
  git add .
  git -c user.name="ios-studio-scaffold" -c user.email="scaffold@users.noreply.github.com" \
    commit -m "chore: scaffold ${APP_NAME} from ios-studio TemplateApp"
  gh repo create "${OWNER}/${REPO_NAME}" \
    "--${VISIBILITY}" \
    --source=. \
    --remote=origin \
    --push \
    --description "iOS app using OverloadKit from ios-studio"
)

echo "✓ Created https://github.com/${OWNER}/${REPO_NAME}"
