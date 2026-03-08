#!/bin/bash
# Remove JMLP hooks from Claude Code settings

set -e

SETTINGS_FILE="$HOME/.claude/settings.json"

if [ ! -f "$SETTINGS_FILE" ]; then
    echo "No settings file found. Nothing to uninstall."
    exit 0
fi

if ! command -v jq &> /dev/null; then
    echo "Error: jq is required. Install with: brew install jq"
    exit 1
fi

# Remove the hooks key
CLEANED=$(jq 'del(.hooks)' "$SETTINGS_FILE")
echo "$CLEANED" > "$SETTINGS_FILE"

echo "JMLP hooks removed from Claude Code settings."
