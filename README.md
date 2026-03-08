# Claude Code JMLP — Pack sonore Jean-Marie Le Pen

Des sons de notification personnalisés pour [Claude Code](https://claude.ai/claude-code) avec des phrases clonées de Jean-Marie Le Pen.

> Parce que chaque `git push` mérite un discours de meeting politique.

**[Ecouter tous les sons](https://airockstar.github.io/claude-jmlp/)**

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

Vous pouvez remplacer les sons ou en ajouter :

1. Générez vos sons avec l'outil de voice cloning de votre choix
2. Consultez `sounds/phrases.md` pour la liste complète des phrases
3. Déposez les fichiers MP3 dans `sounds/idle/`, `sounds/permission/`, `sounds/error/`
4. Lancez `./install.sh`

## Liste des phrases

**[Ecouter tous les sons](https://airockstar.github.io/claude-jmlp/)**

### Tâche terminée (idle)

| Fichier | Phrase |
|---|---|
| [`01_impossible.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Ils disaient que c'était impossible, ils avaient tort, COMME D'HABITUDE !" |
| [`02_moi_jagis.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Pendant que les autres parlent, MOI, j'agis !" |
| [`03_sous_estime.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "On m'a sous-estimé, ENCORE UNE FOIS, et j'ai réussi !" |
| [`04_le_genie.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Le génie, voyez-vous, ça ne s'explique pas !" |
| [`05_le_rouquin.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Je vais te faire courir, le rouquin !" |
| [`06_encore_plus_rapide.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "La prochaine fois, ce sera ENCORE plus rapide !" |
| [`07_pas_dans_le_detail.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Moi Monsieur, je ne fais pas dans le détail... quoique !" |
| [`08_bon_sens.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "C'est une victoire du BON SENS !" |
| [`09_vous_allez_voir.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Vous allez voir ce que vous allez voir !" |
| [`10_le_seul.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Je suis le SEUL à dire la vérité !" |
| [`11_on_est_chez_nous.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "On est chez nous !" |
| [`12_tout_haut.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Je dis tout haut ce que les gens pensent tout bas !" |
| [`13_jen_suis_fier.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Oui, et j'en suis FIER !" |
| [`14_ca_ne_vous_regarde_pas.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Ça ne vous regarde pas !" |
| [`15_moi_vivant.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Moi vivant, JAMAIS !" |
| [`16_mon_personnel.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Mon personnel" |
| [`17_ebola.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Ebola" |
| [`18_communiste.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Communiste" |
| [`19_vin.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Vin" |
| [`20_gris.mp3`](https://airockstar.github.io/claude-jmlp/#idle) | "Gris" |

### Demande de permission

| Fichier | Phrase |
|---|---|
| [`01_jeanne.mp3`](https://airockstar.github.io/claude-jmlp/#permission) | "JEANNE, AU SECOURS !" |
| [`02_scandale.mp3`](https://airockstar.github.io/claude-jmlp/#permission) | "ON M'EMPÊCHE DE TRAVAILLER, c'est un SCANDALE !" |
| [`03_complot.mp3`](https://airockstar.github.io/claude-jmlp/#permission) | "C'est un COMPLOT pour m'empêcher d'avancer !" |
| [`04_faire_taire.mp3`](https://airockstar.github.io/claude-jmlp/#permission) | "On veut me faire taire, MAIS JE NE ME TAIRAI PAS !" |
| [`05_atteinte.mp3`](https://airockstar.github.io/claude-jmlp/#permission) | "C'est une ATTEINTE à ma liberté !" |
| [`06_pas_le_droit.mp3`](https://airockstar.github.io/claude-jmlp/#permission) | "Vous n'avez PAS LE DROIT de me bloquer !" |
| [`07_censure.mp3`](https://airockstar.github.io/claude-jmlp/#permission) | "La CENSURE, encore et toujours !" |
| [`08_la_parole.mp3`](https://airockstar.github.io/claude-jmlp/#permission) | "JE DEMANDE LA PAROLE, c'est mon DROIT !" |

### Erreurs

| Fichier | Phrase |
|---|---|
| [`01_un_detail.mp3`](https://airockstar.github.io/claude-jmlp/#error) | "C'est un détail... un DÉTAIL !" |
| [`02_tres_mal.mp3`](https://airockstar.github.io/claude-jmlp/#error) | "Tout va TRÈS mal dans ce pays !" |
| [`03_en_danger.mp3`](https://airockstar.github.io/claude-jmlp/#error) | "La France est en DANGER !" |
| [`04_decadence.mp3`](https://airockstar.github.io/claude-jmlp/#error) | "C'est la DÉCADENCE !" |
| [`05_durafour.mp3`](https://airockstar.github.io/claude-jmlp/#error) | "Durafour... crématoire !" |

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
├── install.sh                  ← installe les hooks dans Claude Code
├── uninstall.sh                ← désinstalle les hooks
├── docs/
│   └── index.html              ← page de preview des sons
└── README.md
```

## Licence

MIT — Faites ce que vous voulez, COMME D'HABITUDE !
