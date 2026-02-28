extends Control

## Main Menu - Starting screen of the game

@onready var play_button: Button = $VBoxContainer/PlayButton if has_node("VBoxContainer/PlayButton") else null
@onready var level_select_button: Button = $VBoxContainer/LevelSelectButton if has_node("VBoxContainer/LevelSelectButton") else null
@onready var quit_button: Button = $VBoxContainer/QuitButton if has_node("VBoxContainer/QuitButton") else null

func _ready() -> void:
	if play_button:
		play_button.pressed.connect(_on_play_pressed)
	if level_select_button:
		level_select_button.pressed.connect(_on_level_select_pressed)
	if quit_button:
		quit_button.pressed.connect(_on_quit_pressed)

func _on_play_pressed() -> void:
	# Load the last played level or level 1
	var current_level = SaveManager.get_current_level()
	LevelManager.load_level(current_level)

func _on_level_select_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
