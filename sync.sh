#!/usr/bin/env bash
#
# sync.sh — pull reference content from the source repos into docs/.
# Source repos stay authoritative; this repo is the published artifact.
#
# Two modes (same source manifest, so they never drift):
#   local  (default) : copy from sibling repos under ../  (your ~/GITHUB/PUBLIC tree)
#   remote (REMOTE=1): fetch from raw.githubusercontent.com  (used by CI/resync)
#
# Only PUBLIC source repos are listed (GitHub Pages is world-readable).
#
#   ./sync.sh                # local copy from sibling repos
#   REMOTE=1 ./sync.sh       # fetch latest from GitHub (no local checkout needed)
#   SRC_ROOT=/path ./sync.sh # override local sibling root
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="${SRC_ROOT:-$ROOT/..}"          # local mode: sibling repos live here
OWNER="${OWNER:-sbj-ee}"
REMOTE="${REMOTE:-0}"

# Source manifest: "repo<TAB>branch<TAB>path-in-repo<TAB>dest-in-docs"
SOURCES=(
  "EE_Ref	main	README.md	docs/ee/index.md"
  "C_Programming	main	README.md	docs/c/index.md"
  "tmux_cheat_sheet	main	tmux_cheat_sheet.md	docs/tmux/index.md"
  "Ansible_Playbooks	main	README.md	docs/ansible/index.md"
  "pynetbox_examples	main	README.md	docs/netbox/index.md"
)

fetch() {  # fetch <repo> <branch> <path> <dest>
  local repo="$1" branch="$2" path="$3" dest="$4"
  mkdir -p "$(dirname "$ROOT/$dest")"
  if [[ "$REMOTE" == "1" ]]; then
    local url="https://raw.githubusercontent.com/$OWNER/$repo/$branch/$path"
    if curl -fsSL "$url" -o "$ROOT/$dest"; then
      echo "  ok   $repo:$path -> $dest  (remote)"
    else
      echo "  FAIL $url" >&2; return 1
    fi
  else
    if [[ -f "$SRC/$repo/$path" ]]; then
      cp "$SRC/$repo/$path" "$ROOT/$dest"
      echo "  ok   $repo:$path -> $dest  (local)"
    else
      echo "  MISS $SRC/$repo/$path (not found locally)" >&2; return 1
    fi
  fi
}

echo "Syncing knowledge-base content (mode=$([[ $REMOTE == 1 ]] && echo remote || echo local))"
rc=0
for line in "${SOURCES[@]}"; do
  IFS=$'\t' read -r repo branch path dest <<<"$line"
  fetch "$repo" "$branch" "$path" "$dest" || rc=1
done

# Rewrite self-referential relative links to absolute GitHub URLs so the strict
# MkDocs build (used by the deploy workflow) doesn't fail on them.
sed -i 's#](tmux_cheat_sheet\.md)#](https://github.com/sbj-ee/tmux_cheat_sheet/blob/main/tmux_cheat_sheet.md)#g' \
  "$ROOT/docs/tmux/index.md"
sed -i 's#](EE-Book\.pdf)#](https://github.com/sbj-ee/EE_Ref/blob/main/EE-Book.pdf)#g' \
  "$ROOT/docs/ee/index.md"

echo "Done. Preview with:  uv run mkdocs serve"
exit $rc
