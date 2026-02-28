# Line Craze 🎮

A complete maze puzzle game built with **Godot 4.5**

![Godot](https://img.shields.io/badge/Godot-4.5-blue.svg)
![Status](https://img.shields.io/badge/Status-Complete-success.svg)
![Levels](https://img.shields.io/badge/Levels-60-orange.svg)

## 🎯 Overview

Line Craze is a maze puzzle game where you navigate a ball through challenging levels, collecting keys, avoiding enemies, and racing against the clock!

## ✨ Features

### Core Gameplay
- **60 Progressive Levels** - From beginner to expert difficulty
- **Smooth Ball Physics** - Acceleration and friction-based movement
- **Enemy AI** - Enemies chase and patrol with intelligent behavior
- **Key Collection** - Gather all keys to unlock gates
- **Timer System** - Track your best times for each level
- **Fog of War** - Limited vision in advanced levels (31-60)
- **Speed Boosters** - Temporary power-ups for faster movement

### Game Systems
- **Save/Load System** - Automatic progress saving
- **Level Unlock Progression** - Unlock levels by completing previous ones
- **Best Time Tracking** - Compete with yourself for better times
- **Complete UI** - Menu, level select, HUD, pause, and completion screens

## 🎮 Controls

- **WASD** or **Arrow Keys** - Move the ball
- **ESC** - Pause/Resume game
- **Mouse** - Navigate menus

## 🚀 Quick Start

1. **Requirements**: Godot Engine 4.5 or later
2. **Clone** the repository:
   ```bash
   git clone https://github.com/junaidmalik0071689-stack/Line-Craze.git
   ```
3. **Open** in Godot Engine
4. **Press F5** to play!

For detailed instructions, see [QUICKSTART.md](QUICKSTART.md)

## 📚 Documentation

- **[QUICKSTART.md](QUICKSTART.md)** - How to play the game
- **[GAME_DOCUMENTATION.md](GAME_DOCUMENTATION.md)** - Technical documentation
- **[IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)** - Project overview

## 🏗️ Project Structure

```
Line-Craze/
├── scripts/          # 16 GDScript files (game logic)
├── scenes/           # 12 scene files (game entities & UI)
├── levels/           # 60 level files
├── project.godot     # Main project configuration
└── *.md              # Documentation files
```

## 🎯 Game Mechanics

### Player Movement
- Smooth acceleration and deceleration
- Responsive controls
- Speed boost power-ups

### Enemy System
- Detection radius (400 pixels)
- Chase behavior when player is near
- Patrol behavior when player is far
- Instant death on contact

### Progression
- **Levels 1-10**: Basic tutorials
- **Levels 11-30**: Intermediate challenges with enemies
- **Levels 31-60**: Advanced levels with fog system

## 📊 Statistics

- **Total Files**: 94
- **Scripts**: 16 (873 lines of code)
- **Scenes**: 12
- **Levels**: 60
- **Documentation**: 4 comprehensive guides

## 🛠️ Technology

- **Engine**: Godot 4.5
- **Language**: GDScript
- **Architecture**: Autoload singletons, signal-based communication
- **Save Format**: JSON

## 🎓 For Developers

All scripts are well-documented with:
- Type hints for better IDE support
- Export variables for easy customization
- Signal-based event system
- Modular and reusable components

See [GAME_DOCUMENTATION.md](GAME_DOCUMENTATION.md) for technical details.

## 📝 License

Created for educational and entertainment purposes.

## 🙏 Acknowledgments

Built with Godot Engine - https://godotengine.org

---

**Status**: ✅ Complete and Ready to Play!

For questions or issues, please open an issue on GitHub.
