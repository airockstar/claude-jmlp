# Claude Code JMLP — Pack sonore Jean-Marie Le Pen

Des sons de notification personnalisés pour [Claude Code](https://claude.ai/claude-code) avec des phrases clonées de Jean-Marie Le Pen.

> Parce que chaque `git push` mérite un discours de meeting politique.

## Comment ça marche

Claude Code utilise un système de [hooks](https://docs.anthropic.com/en/docs/claude-code/hooks) qui permet d'exécuter des commandes shell sur certains événements. Ce projet joue des phrases JMLP générées par IA sur deux événements :

- **Tâche terminée** (`idle_prompt`) — JMLP triomphe avec une phrase aléatoire parmi 15
- **Demande de permission** (`permission_prompt`) — JMLP s'indigne avec une phrase aléatoire parmi 8
- **Erreur** — des phrases bonus dramatiques (5 clips)

## Prérequis

- macOS (utilise `afplay` pour jouer les sons)
- `jq` (installer avec `brew install jq`)
- [Claude Code](https://claude.ai/claude-code)

## Installation

```bash
git clone https://github.com/airockstar/claude-jmlp.git
cd claude-jmlp
chmod +x install.sh
./install.sh
```

Relancez Claude Code pour que les hooks prennent effet.

## Désinstallation

```bash
./uninstall.sh
```

## Tester les sons

```bash
# Son aléatoire "tâche terminée"
bash hooks/play-sound.sh idle

# Son aléatoire "demande de permission"
bash hooks/play-sound.sh permission

# Son aléatoire "erreur"
bash hooks/play-sound.sh error
```

## Générer vos propres sons

Les sons inclus ont été générés avec [ElevenLabs](https://elevenlabs.io) (voice cloning). Vous pouvez régénérer les sons ou en ajouter :

### Avec ElevenLabs (recommandé)

1. Créez un compte [ElevenLabs](https://elevenlabs.io) (plan Starter, 5$/mois)
2. Clonez une voix avec un extrait audio de référence
3. Récupérez votre clé API et l'ID de la voix clonée
4. Lancez le script de génération :

```bash
export ELEVENLABS_API_KEY="votre_cle"
export ELEVENLABS_VOICE_ID="id_de_la_voix"
./generate-sounds.sh
```

Le script génère les 28 clips automatiquement. Les fichiers existants ne sont pas écrasés (supprimez-les d'abord pour regénérer).

### Manuellement

1. Générez vos sons avec l'outil de votre choix
2. Consultez `sounds/phrases.md` pour la liste complète des phrases
3. Déposez les fichiers MP3 dans `sounds/idle/`, `sounds/permission/`, `sounds/error/`
4. Lancez `./install.sh`

## Liste des phrases

### Tâche terminée (idle)

| Fichier | Phrase |
|---|---|
| `01_impossible.mp3` | "Ils disaient que c'était impossible, ils avaient tort, COMME D'HABITUDE !" |
| `02_moi_jagis.mp3` | "Pendant que les autres parlent, MOI, j'agis !" |
| `03_sous_estime.mp3` | "On m'a sous-estimé, ENCORE UNE FOIS, et j'ai réussi !" |
| `04_le_genie.mp3` | "Le génie, voyez-vous, ça ne s'explique pas !" |
| `05_le_rouquin.mp3` | "Je vais te faire courir, le rouquin !" |
| `06_encore_plus_rapide.mp3` | "La prochaine fois, ce sera ENCORE plus rapide !" |
| `07_pas_dans_le_detail.mp3` | "Moi Monsieur, je ne fais pas dans le détail... quoique !" |
| `08_bon_sens.mp3` | "C'est une victoire du BON SENS !" |
| `09_vous_allez_voir.mp3` | "Vous allez voir ce que vous allez voir !" |
| `10_le_seul.mp3` | "Je suis le SEUL à dire la vérité !" |
| `11_on_est_chez_nous.mp3` | "On est chez nous !" |
| `12_tout_haut.mp3` | "Je dis tout haut ce que les gens pensent tout bas !" |
| `13_jen_suis_fier.mp3` | "Oui, et j'en suis FIER !" |
| `14_ca_ne_vous_regarde_pas.mp3` | "Ça ne vous regarde pas !" |
| `15_moi_vivant.mp3` | "Moi vivant, JAMAIS !" |

### Demande de permission

| Fichier | Phrase |
|---|---|
| `01_jeanne.mp3` | "JEANNE, AU SECOURS !" |
| `02_scandale.mp3` | "ON M'EMPÊCHE DE TRAVAILLER, c'est un SCANDALE !" |
| `03_complot.mp3` | "C'est un COMPLOT pour m'empêcher d'avancer !" |
| `04_faire_taire.mp3` | "On veut me faire taire, MAIS JE NE ME TAIRAI PAS !" |
| `05_atteinte.mp3` | "C'est une ATTEINTE à ma liberté !" |
| `06_pas_le_droit.mp3` | "Vous n'avez PAS LE DROIT de me bloquer !" |
| `07_censure.mp3` | "La CENSURE, encore et toujours !" |
| `08_la_parole.mp3` | "JE DEMANDE LA PAROLE, c'est mon DROIT !" |

### Erreurs

| Fichier | Phrase |
|---|---|
| `01_un_detail.mp3` | "C'est un détail... un DÉTAIL !" |
| `02_tres_mal.mp3` | "Tout va TRÈS mal dans ce pays !" |
| `03_en_danger.mp3` | "La France est en DANGER !" |
| `04_decadence.mp3` | "C'est la DÉCADENCE !" |
| `05_durafour.mp3` | "Durafour... crématoire !" |

## Structure du projet

```
claude-jmlp/
├── sounds/
│   ├── phrases.md              ← liste des phrases à générer
│   ├── idle/                   ← sons "tâche terminée" (.mp3)
│   ├── permission/             ← sons "demande de permission" (.mp3)
│   └── error/                  ← sons "erreur" (.mp3)
├── hooks/
│   └── play-sound.sh           ← sélection aléatoire + lecture du son
├── generate-sounds.sh          ← génération via API ElevenLabs
├── install.sh                  ← installe les hooks dans Claude Code
├── uninstall.sh                ← désinstalle les hooks
└── README.md
```

## Licence

MIT — Faites ce que vous voulez, COMME D'HABITUDE !
