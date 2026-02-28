extends Control

## Pause Menu - Displayed when game is paused

@onready var resume_button: Button = $Panel/VBoxContainer/ResumeButton if has_node("Panel/VBoxContainer/ResumeButton") else null
@onready var restart_button: Button = $Panel/VBoxContainer/RestartButton if has_node("Panel/VBoxContainer/RestartButton") else null
@onready var menu_button: Button = $Panel/VBoxContainer/MenuButton if has_node("Panel/VBoxContainer/MenuButton") else null

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	if resume_button:
		resume_button.pressed.connect(_on_resume_pressed)
	if restart_button:
		restart_button.pressed.connect(_on_restart_pressed)
	if menu_button:
		menu_button.pressed.connect(_on_menu_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause() -> void:
	if get_tree().paused:
		resume_game()
	else:
		pause_game()

func pause_game() -> void:
	get_tree().paused = true
	visible = true

func resume_game() -> void:
	get_tree().paused = false
	visible = false

func _on_resume_pressed() -> void:
	resume_game()

func _on_restart_pressed() -> void:
	resume_game()
	LevelManager.restart_level()

func _on_menu_pressed() -> void:
	resume_game()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
