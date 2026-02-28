extends Control

## Level Complete Screen - Shown when level is completed

@onready var time_label: Label = $Panel/VBoxContainer/TimeLabel if has_node("Panel/VBoxContainer/TimeLabel") else null
@onready var next_button: Button = $Panel/VBoxContainer/NextButton if has_node("Panel/VBoxContainer/NextButton") else null
@onready var restart_button: Button = $Panel/VBoxContainer/RestartButton if has_node("Panel/VBoxContainer/RestartButton") else null
@onready var menu_button: Button = $Panel/VBoxContainer/MenuButton if has_node("Panel/VBoxContainer/MenuButton") else null

var level_time: float = 0.0

func _ready() -> void:
	if next_button:
		next_button.pressed.connect(_on_next_pressed)
	if restart_button:
		restart_button.pressed.connect(_on_restart_pressed)
	if menu_button:
		menu_button.pressed.connect(_on_menu_pressed)

func show_completion(time: float) -> void:
	level_time = time
	if time_label:
		time_label.text = "Time: " + LevelManager.format_time(time)
	visible = true

func _on_next_pressed() -> void:
	LevelManager.load_next_level()

func _on_restart_pressed() -> void:
	LevelManager.restart_level()

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
