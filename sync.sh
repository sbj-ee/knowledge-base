#!/usr/bin/env bash
#
# sync.sh — re-copy reference content from the source repos into docs/.
# Source repos stay authoritative; this repo is the published artifact.
#
# Only PUBLIC source repos are included (GitHub Pages is world-readable).
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="${SRC_ROOT:-$ROOT/..}"   # default: sibling repos under PUBLIC/

copy() {  # copy <src-file> <dest-file>
  if [[ -f "$SRC/$1" ]]; then
    mkdir -p "$(dirname "$ROOT/$2")"
    cp "$SRC/$1" "$ROOT/$2"
    echo "  ok   $1 -> $2"
  else
    echo "  MISS $1 (not found under $SRC)" >&2
  fi
}

echo "Syncing knowledge-base content from $SRC"
copy "EE_Ref/README.md"                       "docs/ee/index.md"
copy "tmux_cheat_sheet/tmux_cheat_sheet.md"   "docs/tmux/index.md"

# Rewrite self-referential relative links to absolute GitHub URLs so the
# strict MkDocs build (used by the deploy workflow) doesn't fail on them.
sed -i 's#](tmux_cheat_sheet\.md)#](https://github.com/sbj-ee/tmux_cheat_sheet/blob/main/tmux_cheat_sheet.md)#g' \
  "$ROOT/docs/tmux/index.md"

echo "Done. Preview with:  uv run mkdocs serve"
