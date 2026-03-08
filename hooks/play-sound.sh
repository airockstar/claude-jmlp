#!/bin/bash
# Play a random sound from a category directory
# Usage: play-sound.sh <category>
# Categories: idle, permission, error

exec < /dev/null

SCRIPT_DIR="$(dirname "$0")"
SOUNDS_DIR="$SCRIPT_DIR/../sounds"
CATEGORY="${1:-idle}"
DIR="$SOUNDS_DIR/$CATEGORY"

if [ ! -d "$DIR" ]; then
    exit 0
fi

shopt -s nullglob
VALID=("$DIR"/*.mp3 "$DIR"/*.aiff "$DIR"/*.wav)

if [ ${#VALID[@]} -eq 0 ]; then
    exit 0
fi

PICK="${VALID[$RANDOM % ${#VALID[@]}]}"
afplay "$PICK" &
disown

exit 0
