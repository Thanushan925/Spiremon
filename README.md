# Spirémon - Interactive Media Final Project

## Overview
Spirémon is a turn-based roguelike inspired by Slay the Spire and Pokémon. Players progress through a series of nodes, battle enemies, collect moves, and upgrade their character to prepare for a final boss encounter at 10/10.

The game focuses on strategic decision-making, resource management, and adapting to increasing difficulty throughout each run.

Video Essay: https://youtu.be/-ld9M77pqr8

---

## Downloads
Prebuilt game downloads for each platform are available in the GitHub Releases section of this repository.

Recommended release asset names:
- Spiremon-windows.zip
- Spiremon-linux.zip
- Spiremon-macos.zip

---

## How to Run

### Windows
1. Download and extract `Spiremon-windows.zip`
2. Open the extracted folder
3. Run `Spiremon.exe`

Expected contents:
- `Spiremon.exe`
- `Spiremon.pck`

Optional:
- `Spiremon.console.exe` may also be included for debugging purposes

### Linux
1. Download and extract `Spiremon-linux.zip`
2. Open a terminal in the extracted folder
3. Run:
   ```bash
   chmod +x Spiremon.exe.x86_64
   chmod +x Spiremon.exe.sh
   ./Spiremon.exe.sh

Expected contents:
- `Spiremon.exe.x86_64`
- `Spiremon.exe.pck`
- `Spiremon.exe.sh`

### macOS
1. Download and extract `Spiremon-macos.zip`
2. Open the extracted folder
3. Right-click `Spiremon.app` and click Open
    - If macOS warns that the app is from an unidentified developer, click Open again or go to:
    -  System Settings → Privacy & Security → Open Anyway
  
Expected contents:
- `Spiremon.app`
- `Spiremon.command`

Note:
The macOS build is not notarized, so Gatekeeper may warn or block it on first launch.
If needed, `Spiremon.command` can be used as a fallback launcher.

---

## Controls

- Mouse:
  - Click on nodes to select paths
  - Click move buttons to attack
  - Click "End Turn" to pass your turn
  - Click UI buttons to navigate menus

---

## Gameplay

- Each run progresses from **1/10 → 10/10**
- At each node, choose between:
  - Battle (fight enemies and gain moves)
  - Heal (restore HP)
  - Upgrade (improve moves or increase max HP)
- Manage energy (3 per turn) to use moves strategically
- Status effects (Burn, Poison, Freeze, Paralysis) affect combat
- Final boss appears at **10/10**

---

## Features

- Turn-based combat system
- Energy-based decision making
- Data-driven move and status system
- Multiple starter characters (unlockable)
- Scaling difficulty system
- Boss fight with enhanced effects
- Audio feedback (music + sound effects)
- Visual feedback (animations, screen shake, UI updates)

---

## Known Issues

- macOS version may trigger security warnings if not signed and not run as well as Windows/Linux
- Some UI elements may slightly shift during heavy animations
- Balance may not be perfect across all runs

---

## Asset Credits

- Pokémon sprites: obtained from https://pokemondb.net
- Sound effects and music: obtained from https://downloads.khinsider.com and Spotify
- Background images: obtained from Google Images

---

## Notes

- This project was created for an academic assignment and not for commercial-use or monetary value
- Designed to demonstrate game design principles, system interaction, and implementation in Godot
- Focus was placed on creating a complete, stable, and playable experience

---

## Developer

Thanushan Satheeskumar (Computer Science Student @ Ontario Tech University)