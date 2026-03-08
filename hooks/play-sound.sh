#!/bin/bash
# Play a random sound from a category directory
# Usage: play-sound.sh <category>
# Categories: idle, permission, error
# Supports: macOS, Linux, WSL, Git Bash (Windows)

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

play_windows() {
    local win_path
    win_path=$(wslpath -w "$1" 2>/dev/null || cygpath -w "$1" 2>/dev/null || echo "$1")
    powershell.exe -c "
        Add-Type -AssemblyName presentationCore
        \$p = New-Object System.Windows.Media.MediaPlayer
        \$p.Open('$win_path')
        \$p.Play()
        Start-Sleep -Seconds 5
    " &
}

case "$(uname -s)" in
    Darwin)
        afplay "$PICK" &
        ;;
    Linux)
        if grep -qi microsoft /proc/version 2>/dev/null; then
            play_windows "$PICK"
        elif command -v paplay &>/dev/null; then
            paplay "$PICK" &
        elif command -v mpv &>/dev/null; then
            mpv --no-video --really-quiet "$PICK" &
        elif command -v ffplay &>/dev/null; then
            ffplay -nodisp -autoexit -loglevel quiet "$PICK" &
        fi
        ;;
    MINGW*|MSYS*|CYGWIN*)
        play_windows "$PICK"
        ;;
esac

disown 2>/dev/null
exit 0
