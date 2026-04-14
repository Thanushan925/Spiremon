# Spirémon - Interactive Media Final Project

## Overview
Spirémon is a turn-based roguelike inspired by Slay the Spire and Pokémon. Players progress through a series of nodes, battle enemies, collect moves, and upgrade their character to prepare for a final boss encounter at 10/10.

The game focuses on strategic decision-making, resource management, and adapting to increasing difficulty throughout each run.

---

## How to Run

### Windows
1. Navigate to the `builds/windows` folder
2. Run `Spiremon.exe`

### Linux
1. Navigate to the `builds/linux` folder
2. Open a terminal in that directory
3. Run:
   chmod +x Spiremon.x86_64
   ./Spiremon.x86_64

### macOS (beta)
1. Navigate to the `builds/macos` folder
2. Unzip the file if needed
3. Right-click the `.app` file and click **Open**
   - If macOS blocks the app, go to:
     System Settings → Privacy & Security → Allow Anyway
4. You might have to open through Godot

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