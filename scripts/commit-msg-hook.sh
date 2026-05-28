#!/bin/bash
# commit-msg hook: enforce Assisted-by trailer on every commit

MSG_FILE="$1"

# Allow merge, squash, and revert commits (they have fixed formats)
HEAD_LINE=$(head -n1 "$MSG_FILE")
if echo "$HEAD_LINE" | grep -qE '^(Merge|Squash|Revert)'; then
  exit 0
fi

# Allow if message contains at least one Assisted-by or Co-authored-by trailer
if grep -qE '^Assisted-by:|^Co-authored-by:' "$MSG_FILE"; then
  exit 0
fi

cat >&2 <<'EOF'
ERROR: Commit rejected — missing AI agent trailer.

Every commit must include an Assisted-by trailer in the footer:

  Assisted-by: Kimi <kimi@kimi.moonshot.cn>
  Assisted-by: Claude <claude@anthropic.com>
  Assisted-by: Cursor <cursor@cursor.com>

Multiple agents: add one line per agent.
Merge / squash / revert commits are exempt.
EOF

exit 1
