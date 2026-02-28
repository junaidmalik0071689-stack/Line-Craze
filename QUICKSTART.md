# Line Craze - Quick Start Guide

## Opening the Project

### Prerequisites
- Godot Engine 4.5 or later installed
- Git (optional, for cloning)

### Steps to Open

1. **Clone or Download the Repository**
   ```bash
   git clone https://github.com/junaidmalik0071689-stack/Line-Craze.git
   cd Line-Craze
   ```

2. **Open in Godot**
   - Launch Godot Engine 4.5
   - Click "Import" 
   - Navigate to the project folder
   - Select the `project.godot` file
   - Click "Import & Edit"

3. **First Run**
   - Press F5 or click the "Play" button (▶) to run the game
   - The main menu will appear
   - Click "PLAY" to start from Level 1

## Game Controls

### Movement
- **W** or **↑**: Move Up
- **A** or **←**: Move Left
- **S** or **↓**: Move Down
- **D** or **→**: Move Right

### Menu
- **ESC**: Pause/Resume game
- **Mouse**: Navigate menus and select levels

## Game Flow

### Main Menu
- **PLAY**: Start from your last played level (or Level 1 if new)
- **LEVEL SELECT**: Choose from unlocked levels
- **QUIT**: Exit the game

### During Gameplay
1. Move the ball (player) from start to goal
2. Collect all keys (yellow squares)
3. Avoid enemies (red circles)
4. Gates (purple rectangles) open when all keys are collected
5. Reach the goal (green circle) to complete the level
6. Try to beat your best time!

### Level Complete
- **NEXT LEVEL**: Continue to the next level
- **RESTART**: Replay the current level
- **MAIN MENU**: Return to main menu

### Pause Menu (ESC during gameplay)
- **RESUME**: Continue playing
- **RESTART**: Restart current level
- **MAIN MENU**: Return to main menu

## Level Progression

- **Levels 1-10**: Basic tutorials - Learn movement and key collection
- **Levels 11-30**: Intermediate - Enemies and more complex mazes
- **Levels 31-60**: Advanced - Fog system adds challenge

## Tips for Success

1. **Plan Your Route**: Look at the level layout before moving
2. **Watch Enemy Patterns**: Enemies have patrol routes when not chasing
3. **Collect Keys First**: You need all keys before gates open
4. **Stay Away from Enemies**: They have a detection radius - avoid getting too close
5. **Speed Boosters**: Blue items give temporary speed boost
6. **Practice**: Each level can be replayed to improve your time

## Game Features

### Save System
- Progress automatically saves
- Best times are recorded for each level
- You can replay any unlocked level

### Level Select
- Shows all 60 levels
- Green = Completed
- White = Unlocked but not completed
- Gray = Locked

## Troubleshooting

### Game won't start
- Ensure Godot 4.5 or later is installed
- Check the Output panel in Godot editor for errors

### Missing textures/visual glitches
- The game uses ColorRect for simplicity
- This is intentional for the prototype

### Controls not working
- Verify input map in Project Settings > Input Map
- Check if another application is capturing keyboard input

## Project Structure

```
Line-Craze/
├── scenes/       # All scene files (.tscn)
├── scripts/      # All GDScript files (.gd)
├── levels/       # 60 level files
├── project.godot # Main project file
└── icon.svg      # Game icon
```

## Development Mode

### Testing Specific Levels
1. Open any level file from `levels/` folder in Godot editor
2. Click "Play Scene" (F6) to test that specific level

### Modifying Levels
1. Open level file in Godot editor
2. Edit player position, keys, enemies, gates as needed
3. Save the scene (Ctrl+S)
4. Test with F6

### Creating New Levels
1. Duplicate `scenes/level_template.tscn`
2. Save as `levels/level_X.tscn`
3. Edit the layout
4. Update level_number in the level script

## Next Steps

- Complete all 60 levels
- Try to beat your best times
- Challenge friends to beat your times
- Create custom levels by modifying existing ones

## Getting Help

- Check GAME_DOCUMENTATION.md for detailed information
- Review script comments for technical details
- Inspect existing levels for layout examples

## Have Fun!

Enjoy playing Line Craze! The game progressively gets more challenging, so don't get discouraged. Practice makes perfect!
