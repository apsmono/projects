#!/bin/bash
# Install commit-msg hook into parent repo and all submodules

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOK_SRC="$SCRIPT_DIR/commit-msg-hook.sh"

if [[ ! -f "$HOOK_SRC" ]]; then
  echo "Error: hook source not found at $HOOK_SRC" >&2
  exit 1
fi

install_hook() {
  local repo_path="$1"
  local hook_dst="$repo_path/.git/hooks/commit-msg"

  if [[ ! -d "$repo_path/.git" ]]; then
    echo "SKIP: $repo_path (not a git repo)"
    return
  fi

  cp "$HOOK_SRC" "$hook_dst"
  chmod +x "$hook_dst"
  echo "OK:    $repo_path"
}

echo "Installing commit-msg hooks..."
echo ""

# Parent repo
install_hook "."

# Submodules
for submodule in dashboard solo-leveling wedding-invitation koperasi scrapers microservices; do
  if [[ -d "$submodule/.git" ]]; then
    install_hook "$submodule"
  else
    echo "SKIP:  $submodule (no .git directory)"
  fi
done

echo ""
echo "Done."
