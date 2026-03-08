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

# Register hooks using Python for reliable JSON manipulation (inspired by peon-ping)
python3 -c "
import json, os

settings_path = '$SETTINGS_FILE'
hook_cmd = '$HOOK_SCRIPT'

if os.path.exists(settings_path):
    with open(settings_path) as f:
        settings = json.load(f)
else:
    settings = {}

hooks = settings.setdefault('hooks', {})

# Notification hooks (async so they don't block Claude Code)
notification_hooks = [
    h for h in hooks.get('Notification', [])
    if not any('play-sound.sh' in hk.get('command', '') for hk in h.get('hooks', []))
]
notification_hooks.append({
    'matcher': 'idle_prompt',
    'hooks': [{'type': 'command', 'command': hook_cmd + ' idle', 'timeout': 10}]
})
notification_hooks.append({
    'matcher': 'permission_prompt',
    'hooks': [{'type': 'command', 'command': hook_cmd + ' permission', 'timeout': 10}]
})
hooks['Notification'] = notification_hooks

# Stop hook (task completed - async)
stop_hooks = [
    h for h in hooks.get('Stop', [])
    if not any('play-sound.sh' in hk.get('command', '') for hk in h.get('hooks', []))
]
stop_hooks.append({
    'matcher': '',
    'hooks': [{'type': 'command', 'command': hook_cmd + ' idle', 'timeout': 10}]
})
hooks['Stop'] = stop_hooks

settings['hooks'] = hooks

with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)
    f.write('\n')

print('Hooks registered: Notification (idle_prompt, permission_prompt), Stop')
"

echo ""
echo "Done! Hooks installed."
echo ""
echo "Restart Claude Code for hooks to take effect."
echo "Test with: bash $HOOK_SCRIPT idle"
echo "Uninstall: run ./uninstall.sh"
