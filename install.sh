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

# Check if python3 is available
if ! command -v python3 &> /dev/null; then
    echo "Error: python3 is required."
    exit 1
fi

# Create settings dir if needed
mkdir -p "$(dirname "$SETTINGS_FILE")"

# Register hooks using Python for reliable JSON manipulation
SETTINGS_FILE="$SETTINGS_FILE" HOOK_SCRIPT="$HOOK_SCRIPT" python3 - <<'PYEOF'
import json, os

settings_path = os.environ['SETTINGS_FILE']
hook_cmd = os.environ['HOOK_SCRIPT']

if os.path.exists(settings_path):
    with open(settings_path) as f:
        settings = json.load(f)
else:
    settings = {}

hooks = settings.setdefault('hooks', {})

def clean_hooks(hook_list):
    return [
        h for h in hook_list
        if not any('play-sound.sh' in hk.get('command', '') for hk in h.get('hooks', []))
    ]

# Notification hooks
notification_hooks = clean_hooks(hooks.get('Notification', []))
notification_hooks.append({
    'matcher': 'idle_prompt',
    'hooks': [{'type': 'command', 'command': hook_cmd + ' idle', 'timeout': 10}]
})
notification_hooks.append({
    'matcher': 'permission_prompt',
    'hooks': [{'type': 'command', 'command': hook_cmd + ' permission', 'timeout': 10}]
})
hooks['Notification'] = notification_hooks

# Stop hook (task completed)
stop_hooks = clean_hooks(hooks.get('Stop', []))
stop_hooks.append({
    'matcher': '',
    'hooks': [{'type': 'command', 'command': hook_cmd + ' idle', 'timeout': 10}]
})
hooks['Stop'] = stop_hooks

with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)
    f.write('\n')

print('Hooks registered: Notification (idle_prompt, permission_prompt), Stop')
PYEOF

echo ""
echo "Done! Hooks installed."
echo ""
echo "Restart Claude Code for hooks to take effect."
echo "Test with: bash $HOOK_SCRIPT idle"
echo "Uninstall: run ./uninstall.sh"
