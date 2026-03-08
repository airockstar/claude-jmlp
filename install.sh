#!/bin/bash
# Install JMLP hooks into Claude Code settings
# This merges hook config into ~/.claude/settings.json

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HOOK_SCRIPT="$SCRIPT_DIR/hooks/play-sound.sh"
SETTINGS_FILE="$HOME/.claude/settings.json"

# Make hook script executable
chmod +x "$HOOK_SCRIPT"

echo "=== Claude Code JMLP Sound Hooks Installer ==="
echo ""
echo "This will add notification hooks to: $SETTINGS_FILE"
echo "Hook script: $HOOK_SCRIPT"
echo ""

# Check if sounds exist
for category in idle permission error; do
    count=$(find "$SCRIPT_DIR/sounds/$category" -type f \( -name "*.mp3" -o -name "*.aiff" -o -name "*.wav" \) 2>/dev/null | wc -l | tr -d ' ')
    echo "  $category/ : $count sound(s) found"
done
echo ""

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required. Install with: brew install jq"
    exit 1
fi

# Create settings file if it doesn't exist
if [ ! -f "$SETTINGS_FILE" ]; then
    mkdir -p "$(dirname "$SETTINGS_FILE")"
    echo '{}' > "$SETTINGS_FILE"
fi

# Build the hooks config
HOOKS_JSON=$(cat <<EOF
{
  "hooks": {
    "Notification": [
      {
        "matcher": "idle_prompt",
        "hooks": [{"type": "command", "command": "$HOOK_SCRIPT idle"}]
      },
      {
        "matcher": "permission_prompt",
        "hooks": [{"type": "command", "command": "$HOOK_SCRIPT permission"}]
      }
    ]
  }
}
EOF
)

# Merge into existing settings
MERGED=$(jq -s '.[0] * .[1]' "$SETTINGS_FILE" <(echo "$HOOKS_JSON"))
echo "$MERGED" > "$SETTINGS_FILE"

echo "Done! Hooks installed."
echo ""
echo "Test with: bash $HOOK_SCRIPT idle"
echo "Uninstall: run ./uninstall.sh"
