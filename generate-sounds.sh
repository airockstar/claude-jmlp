#!/bin/bash
# Generate all JMLP sound clips via ElevenLabs API
#
# Prerequisites:
#   1. Create account on https://elevenlabs.io (Starter plan, $5/month)
#   2. Clone JMLP voice via web UI: https://elevenlabs.io/voice-cloning
#   3. Get your API key from: https://elevenlabs.io/settings/api-keys
#   4. Get your cloned voice ID from: https://elevenlabs.io/voices
#
# Usage:
#   export ELEVENLABS_API_KEY="your_key_here"
#   export ELEVENLABS_VOICE_ID="your_cloned_voice_id"
#   ./generate-sounds.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOUNDS_DIR="$SCRIPT_DIR/sounds"
API_URL="https://api.elevenlabs.io/v1/text-to-speech"

# Check env vars
if [ -z "$ELEVENLABS_API_KEY" ]; then
    echo "Error: ELEVENLABS_API_KEY not set"
    echo "  export ELEVENLABS_API_KEY=\"your_key_here\""
    exit 1
fi

if [ -z "$ELEVENLABS_VOICE_ID" ]; then
    echo "Error: ELEVENLABS_VOICE_ID not set"
    echo "  export ELEVENLABS_VOICE_ID=\"your_cloned_voice_id\""
    exit 1
fi

generate() {
    local category="$1"
    local filename="$2"
    local text="$3"
    local output="$SOUNDS_DIR/$category/$filename"

    if [ -f "$output" ]; then
        echo "  SKIP $category/$filename (already exists)"
        return
    fi

    echo "  GEN  $category/$filename"

    curl -s -X POST "${API_URL}/${ELEVENLABS_VOICE_ID}" \
        -H "xi-api-key: ${ELEVENLABS_API_KEY}" \
        -H "Content-Type: application/json" \
        -d "{
            \"text\": \"$text\",
            \"model_id\": \"eleven_multilingual_v2\",
            \"voice_settings\": {
                \"stability\": 0.3,
                \"similarity_boost\": 0.85,
                \"style\": 0.7,
                \"use_speaker_boost\": true
            }
        }" \
        --output "$output"

    # Brief pause to respect rate limits
    sleep 1
}

echo "=== JMLP Sound Generator ==="
echo "Voice ID: $ELEVENLABS_VOICE_ID"
echo ""

# --- IDLE: task completed ---
echo "[idle] Generating task completed sounds..."
generate "idle" "01_impossible.mp3" \
    "Ils disaient que c'était impossible, ils avaient tort, COMME D'HABITUDE !"
generate "idle" "02_moi_jagis.mp3" \
    "Pendant que les autres parlent, MOI, j'agis !"
generate "idle" "03_sous_estime.mp3" \
    "On m'a sous-estimé, ENCORE UNE FOIS, et j'ai réussi !"
generate "idle" "04_le_genie.mp3" \
    "Le génie, voyez-vous, ça ne s'explique pas !"
generate "idle" "05_le_rouquin.mp3" \
    "Je vais te faire courir, le rouquin !"
generate "idle" "06_encore_plus_rapide.mp3" \
    "La prochaine fois, ce sera ENCORE plus rapide !"
generate "idle" "07_pas_dans_le_detail.mp3" \
    "Moi Monsieur, je ne fais pas dans le détail... quoique !"
generate "idle" "08_bon_sens.mp3" \
    "C'est une victoire du BON SENS !"
generate "idle" "09_vous_allez_voir.mp3" \
    "Vous allez voir ce que vous allez voir !"
generate "idle" "10_le_seul.mp3" \
    "Je suis le SEUL à dire la vérité !"
generate "idle" "11_on_est_chez_nous.mp3" \
    "On est chez nous !"
generate "idle" "12_tout_haut.mp3" \
    "Je dis tout haut ce que les gens pensent tout bas !"
generate "idle" "13_jen_suis_fier.mp3" \
    "Oui, et j'en suis FIER !"
generate "idle" "14_ca_ne_vous_regarde_pas.mp3" \
    "Ça ne vous regarde pas !"
generate "idle" "15_moi_vivant.mp3" \
    "Moi vivant, JAMAIS !"

# --- PERMISSION: needs authorization ---
echo ""
echo "[permission] Generating permission sounds..."
generate "permission" "01_jeanne.mp3" \
    "JEANNE, AU SECOURS !"
generate "permission" "02_scandale.mp3" \
    "ON M'EMPÊCHE DE TRAVAILLER, c'est un SCANDALE !"
generate "permission" "03_complot.mp3" \
    "C'est un COMPLOT pour m'empêcher d'avancer !"
generate "permission" "04_faire_taire.mp3" \
    "On veut me faire taire, MAIS JE NE ME TAIRAI PAS !"
generate "permission" "05_atteinte.mp3" \
    "C'est une ATTEINTE à ma liberté !"
generate "permission" "06_pas_le_droit.mp3" \
    "Vous n'avez PAS LE DROIT de me bloquer !"
generate "permission" "07_censure.mp3" \
    "La CENSURE, encore et toujours !"
generate "permission" "08_la_parole.mp3" \
    "JE DEMANDE LA PAROLE, c'est mon DROIT !"

# --- ERROR: something went wrong ---
echo ""
echo "[error] Generating error sounds..."
generate "error" "01_un_detail.mp3" \
    "C'est un détail... un DÉTAIL !"
generate "error" "02_tres_mal.mp3" \
    "Tout va TRÈS mal dans ce pays !"
generate "error" "03_en_danger.mp3" \
    "La France est en DANGER !"
generate "error" "04_decadence.mp3" \
    "C'est la DÉCADENCE !"
generate "error" "05_durafour.mp3" \
    "Durafour... crématoire !"

echo ""
echo "Done! Generated sounds:"
find "$SOUNDS_DIR" -name "*.mp3" -type f | wc -l | tr -d ' '
echo "clips total"
echo ""
echo "Test with: bash hooks/play-sound.sh idle"
