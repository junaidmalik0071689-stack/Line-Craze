# Line Craze - Game Documentation

## Overview
Line Craze is a maze puzzle game built with Godot 4.5 where players navigate a ball through levels, collecting keys and avoiding enemies to reach the goal.

## Game Mechanics

### Core Gameplay
- **Player Movement**: Control the ball using WASD or Arrow keys
- **Objective**: Navigate from start point to goal (end point)
- **Keys**: Collect all keys in each level
- **Gates**: Automatically unlock when all keys are collected
- **Enemies**: Avoid enemies that chase the player
- **Timer**: Complete levels as fast as possible
- **Fog**: Later levels (31+) feature fog of war for increased difficulty

### Controls
- **W/↑**: Move Up
- **S/↓**: Move Down
- **A/←**: Move Left
- **D/→**: Move Right
- **ESC**: Pause Game

## Features

### Level System
- **60 Levels Total**: Progressive difficulty
- **Level Progression**: 
  - Levels 1-10: Basic maze navigation with 1-2 keys
  - Levels 11-30: More complex mazes with enemies
  - Levels 31-60: Advanced levels with fog system
- **Level Select**: Choose from unlocked levels
- **Level Unlock**: Complete levels to unlock the next

### Save System
- Automatic save progress
- Best times tracked for each level
- Save file location: `user://line_craze_save.json`
- Reset progress option available

### Enemy System
- **Chase Behavior**: Enemies detect and chase the player within detection radius
- **Patrol Behavior**: Enemies patrol between points when player is out of range
- **Detection Radius**: 400 pixels (configurable per enemy)
- **Death**: Contact with enemies causes instant death and level restart

### Booster System
- **Speed Boost**: Temporary speed increase
- **Duration**: 5 seconds (configurable)
- **Visual Feedback**: Blue-tinted collectibles

### Fog System
- **Visibility Radius**: Limited vision around player (200 pixels default)
- **Progressive Difficulty**: Enabled in levels 31+
- **Dynamic**: Follows player movement

## Project Structure

```
Line-Craze/
├── project.godot          # Main project configuration
├── icon.svg              # Game icon
├── .gitignore            # Git ignore rules
├── scenes/               # Scene files
│   ├── main_menu.tscn    # Main menu
│   ├── level_select.tscn # Level selection screen
│   ├── level_template.tscn # Template for new levels
│   ├── level_complete.tscn # Level completion screen
│   ├── pause_menu.tscn   # Pause menu
│   ├── hud.tscn          # Heads-up display
│   ├── player.tscn       # Player ball
│   ├── enemy.tscn        # Enemy entity
│   ├── key.tscn          # Collectible key
│   ├── gate.tscn         # Lockable gate
│   ├── goal.tscn         # Level end point
│   └── booster.tscn      # Speed booster
├── scripts/              # GDScript files
│   ├── player.gd         # Player movement logic
│   ├── enemy.gd          # Enemy AI and chase logic
│   ├── key.gd            # Key collectible logic
│   ├── key_manager.gd    # Key tracking system
│   ├── gate.gd           # Gate unlock logic
│   ├── goal.gd           # Level completion trigger
│   ├── booster.gd        # Booster effect logic
│   ├── fog_system.gd     # Fog of war implementation
│   ├── level_manager.gd  # Level loading and timer (Autoload)
│   ├── save_manager.gd   # Save/load system (Autoload)
│   ├── level_script.gd   # Level initialization script
│   ├── level_complete.gd # Completion screen logic
│   ├── main_menu.gd      # Main menu logic
│   ├── level_select.gd   # Level selection logic
│   ├── pause_menu.gd     # Pause menu logic
│   └── hud.gd            # HUD update logic
└── levels/               # 60 level files
    ├── level_1.tscn
    ├── level_2.tscn
    └── ... (up to level_60.tscn)
```

## Core Scripts

### 1. Player Movement (player.gd)
**Class**: `Player` extends `CharacterBody2D`

**Features**:
- Smooth acceleration and friction
- Speed boost capability
- Key collection tracking
- Death handling
- Signal emissions for game events

**Key Methods**:
- `collect_key()`: Increments key counter
- `apply_speed_boost(duration)`: Applies temporary speed increase
- `die()`: Handles player death
- `reset()`: Resets player state

### 2. Enemy Chase (enemy.gd)
**Class**: `Enemy` extends `CharacterBody2D`

**Features**:
- Player detection and chasing
- Patrol behavior with waypoints
- Configurable detection radius
- Automatic player targeting

**Key Methods**:
- `chase_player(delta)`: Moves toward player
- `patrol(delta)`: Moves between patrol points
- `_on_body_entered(body)`: Handles collision with player

### 3. Key System (key.gd, key_manager.gd)
**Key Class**: Collectible items
**KeyManager Class**: Tracks collection progress

**Features**:
- Automatic collection on contact
- Total key counting
- Collection tracking
- Gate unlock signaling

### 4. Gate Unlock (gate.gd)
**Class**: `Gate` extends `StaticBody2D`

**Features**:
- Automatic unlock when all keys collected
- Visual feedback (transparency)
- Collision disable on open
- Optional manual unlock

**Key Methods**:
- `open_gate()`: Opens the gate
- `close_gate()`: Closes the gate
- `can_player_pass(player)`: Checks if player can pass

### 5. Level Manager (level_manager.gd)
**Autoload**: `LevelManager`

**Features**:
- Level loading and switching
- Timer management
- Level completion tracking
- Integration with save system

**Key Methods**:
- `load_level(level_number)`: Loads specific level
- `start_level()`: Initializes level and timer
- `complete_level()`: Handles level completion
- `restart_level()`: Restarts current level
- `format_time(time)`: Formats time display

## Signals

### Player Signals
- `player_died`: Emitted when player dies
- `key_collected(total_keys)`: Emitted when key is collected
- `reached_goal`: Emitted when player reaches goal

### KeyManager Signals
- `all_keys_collected`: Emitted when all keys are collected
- `key_collected_update(collected, total)`: Progress update

### LevelManager Signals
- `level_completed(level_number, time)`: Level completion
- `level_failed`: Level failure
- `timer_updated(time)`: Timer tick

## Collision Layers

1. **Layer 1**: Player
2. **Layer 2**: Walls
3. **Layer 3**: Enemies
4. **Layer 4**: Collectibles (Keys, Boosters)
5. **Layer 5**: Gates

## Development Notes

### Adding New Levels
1. Duplicate `level_template.tscn`
2. Rename to `level_X.tscn` (where X is the level number)
3. Edit the level layout:
   - Position player start point
   - Add walls and obstacles
   - Place keys
   - Position gates
   - Add enemies with patrol points
   - Place goal/end point
4. Update level script parameters (enable_fog, level_number)

### Customizing Gameplay
- **Player Speed**: Edit `speed` export variable in player.tscn
- **Enemy Detection**: Edit `detection_radius` in enemy.tscn
- **Boost Duration**: Edit `boost_duration` in booster.tscn
- **Fog Radius**: Edit `fog_radius` in level script or fog_system

### Save Data Structure
```json
{
  "unlocked_levels": [1, 2, 3, ...],
  "completed_levels": {
    "1": 45.67,
    "2": 52.34,
    ...
  },
  "current_level": 5
}
```

## Testing

### Quick Test Checklist
- [ ] Player moves in all directions
- [ ] Keys can be collected
- [ ] Gates open when all keys collected
- [ ] Enemies chase and kill player
- [ ] Timer counts up during gameplay
- [ ] Level completes when reaching goal
- [ ] Save/load works correctly
- [ ] Level select shows correct unlock status
- [ ] Pause menu works
- [ ] Level completion screen displays

## Future Enhancement Ideas

1. **Additional Boosters**: Shield, slow time, teleport
2. **More Enemy Types**: Static shooters, teleporting enemies
3. **Obstacles**: Moving platforms, spike traps, laser beams
4. **Power-ups**: Extra lives, key radar, speed trails
5. **Level Editor**: In-game level creation tool
6. **Leaderboards**: Online time tracking
7. **Achievements**: Special challenges and rewards
8. **Sound Effects**: Audio feedback for actions
9. **Music**: Background music for levels and menus
10. **Particle Effects**: Visual polish for collectibles and movement

## Troubleshooting

### Common Issues

**Player not moving**:
- Check input actions are defined in project settings
- Verify collision layers and masks

**Keys not counting**:
- Ensure KeyManager is instantiated in level
- Check key_collected signal connections

**Gates not opening**:
- Verify KeyManager emits all_keys_collected signal
- Check gate's open_automatically export variable

**Level not loading**:
- Confirm level file path matches naming convention
- Check for errors in Output console

**Save not persisting**:
- Verify write permissions for user:// directory
- Check JSON format in save_manager.gd

## Credits

**Engine**: Godot 4.5
**Game Type**: Maze Puzzle
**Development**: Line Craze Team

## License

This project is created for educational and entertainment purposes.
