#!/bin/bash
# Play a random sound from a category directory
# Usage: play-sound.sh <category>
# Categories: idle, permission, error

exec < /dev/null

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOUNDS_DIR="$SCRIPT_DIR/../sounds"
CATEGORY="${1:-idle}"
DIR="$SOUNDS_DIR/$CATEGORY"

if [ ! -d "$DIR" ]; then
    exit 0
fi

# Collect all sound files
shopt -s nullglob
VALID=("$DIR"/*.mp3 "$DIR"/*.aiff "$DIR"/*.wav)
shopt -u nullglob

if [ ${#VALID[@]} -eq 0 ]; then
    exit 0
fi

# Pick a random file and play it detached
PICK="${VALID[$RANDOM % ${#VALID[@]}]}"
nohup afplay "$PICK" > /dev/null 2>&1 &
disown

exit 0
