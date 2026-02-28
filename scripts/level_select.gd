extends Control

## Level Select - Allows player to choose from unlocked levels

const LEVELS_PER_PAGE = 20
const TOTAL_LEVELS = 60

@onready var level_grid: GridContainer = $ScrollContainer/LevelGrid if has_node("ScrollContainer/LevelGrid") else null
@onready var back_button: Button = $BackButton if has_node("BackButton") else null

func _ready() -> void:
	if back_button:
		back_button.pressed.connect(_on_back_pressed)
	
	setup_level_buttons()

func setup_level_buttons() -> void:
	if not level_grid:
		return
	
	# Clear existing buttons
	for child in level_grid.get_children():
		child.queue_free()
	
	# Create buttons for all levels
	for i in range(1, TOTAL_LEVELS + 1):
		var button = Button.new()
		button.text = str(i)
		button.custom_minimum_size = Vector2(80, 80)
		
		# Check if level is unlocked
		var is_unlocked = SaveManager.is_level_unlocked(i)
		var is_completed = SaveManager.is_level_completed(i)
		
		button.disabled = not is_unlocked
		
		# Visual feedback for completed levels
		if is_completed:
			button.modulate = Color.GREEN
		elif is_unlocked:
			button.modulate = Color.WHITE
		else:
			button.modulate = Color.DARK_GRAY
		
		# Connect button press
		var level_number = i
		button.pressed.connect(func(): _on_level_button_pressed(level_number))
		
		level_grid.add_child(button)

func _on_level_button_pressed(level_number: int) -> void:
	LevelManager.load_level(level_number)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
