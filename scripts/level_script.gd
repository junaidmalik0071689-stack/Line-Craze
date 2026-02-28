extends Node2D

## Level Script - Handles level initialization and completion

@export var level_number: int = 1
@export var enable_fog: bool = false
@export var fog_radius: float = 200.0

var key_manager: KeyManager = null
var fog_system: FogSystem = null

func _ready() -> void:
	# Initialize level
	setup_level()
	
	# Start level timer
	LevelManager.start_level()

func setup_level() -> void:
	# Create and setup key manager
	key_manager = KeyManager.new()
	key_manager.add_to_group("key_manager")
	add_child(key_manager)
	
	# Setup fog if enabled
	if enable_fog:
		setup_fog_system()
	
	# Connect player signals
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players[0]
		player.player_died.connect(_on_player_died)

func setup_fog_system() -> void:
	fog_system = FogSystem.new()
	fog_system.visibility_radius = fog_radius
	add_child(fog_system)

func _on_player_died() -> void:
	# Show game over screen or restart
	await get_tree().create_timer(1.0).timeout
	show_level_failed_screen()

func show_level_failed_screen() -> void:
	# For now, just restart the level
	LevelManager.restart_level()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		show_pause_menu()

func show_pause_menu() -> void:
	# Check if pause menu already exists
	var pause_menus = get_tree().get_nodes_in_group("pause_menu")
	if pause_menus.size() == 0:
		var pause_menu_scene = load("res://scenes/pause_menu.tscn")
		if pause_menu_scene:
			var pause_menu = pause_menu_scene.instantiate()
			pause_menu.add_to_group("pause_menu")
			add_child(pause_menu)
			pause_menu.pause_game()
