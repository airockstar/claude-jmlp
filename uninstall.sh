#!/bin/bash
# Remove JMLP hooks from Claude Code settings (keeps other hooks intact)

set -e

SETTINGS_FILE="$HOME/.claude/settings.json"

if [ ! -f "$SETTINGS_FILE" ]; then
    echo "No settings file found. Nothing to uninstall."
    exit 0
fi

if ! command -v python3 &> /dev/null; then
    echo "Error: python3 is required."
    exit 1
fi

SETTINGS_FILE="$SETTINGS_FILE" python3 - <<'PYEOF'
import json, os

settings_path = os.environ['SETTINGS_FILE']

with open(settings_path) as f:
    settings = json.load(f)

hooks = settings.get('hooks', {})

def clean_hooks(hook_list):
    return [
        h for h in hook_list
        if not any('play-sound.sh' in hk.get('command', '') for hk in h.get('hooks', []))
    ]

for event in ('Notification', 'Stop'):
    if event in hooks:
        cleaned = clean_hooks(hooks[event])
        if cleaned:
            hooks[event] = cleaned
        else:
            del hooks[event]

if not hooks:
    del settings['hooks']

with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)
    f.write('\n')
PYEOF

echo "JMLP hooks removed from Claude Code settings."
