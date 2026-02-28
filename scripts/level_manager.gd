extends Node

## Level Manager - Handles level loading, progression, and timer

const TOTAL_LEVELS: int = 60

var current_level: int = 1
var level_time: float = 0.0
var is_timer_running: bool = false
var key_manager: KeyManager = null

signal level_completed(level_number: int, time: float)
signal level_failed
signal timer_updated(time: float)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta: float) -> void:
	if is_timer_running:
		level_time += delta
		timer_updated.emit(level_time)

func load_level(level_number: int) -> void:
	if level_number < 1 or level_number > TOTAL_LEVELS:
		push_error("Invalid level number: " + str(level_number))
		return
	
	current_level = level_number
	reset_level_state()
	
	# Load the level scene
	var level_path = "res://levels/level_%d.tscn" % level_number
	
	# Check if level file exists
	if ResourceLoader.exists(level_path):
		get_tree().call_deferred("change_scene_to_file", level_path)
	else:
		# Load template level if specific level doesn't exist
		var template_path = "res://scenes/level_template.tscn"
		if ResourceLoader.exists(template_path):
			get_tree().call_deferred("change_scene_to_file", template_path)
		else:
			push_error("Level file not found: " + level_path)

func start_level() -> void:
	reset_level_state()
	start_timer()
	
	# Setup key manager
	setup_key_manager()

func reset_level_state() -> void:
	level_time = 0.0
	is_timer_running = false

func setup_key_manager() -> void:
	# Find or create key manager in the current scene
	var managers = get_tree().get_nodes_in_group("key_manager")
	if managers.size() > 0:
		key_manager = managers[0]
	else:
		# Create key manager if it doesn't exist
		key_manager = KeyManager.new()
		key_manager.add_to_group("key_manager")
		get_tree().current_scene.add_child(key_manager)
	
	# Connect player signals
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players[0]
		if not player.key_collected.is_connected(_on_key_collected):
			player.key_collected.connect(_on_key_collected)
		if not player.player_died.is_connected(_on_player_died):
			player.player_died.connect(_on_player_died)

func _on_key_collected(total: int) -> void:
	if key_manager:
		key_manager.register_key_collected()

func start_timer() -> void:
	is_timer_running = true

func stop_timer() -> void:
	is_timer_running = false

func complete_level() -> void:
	stop_timer()
	level_completed.emit(current_level, level_time)
	
	# Update save data
	SaveManager.complete_level(current_level, level_time)
	
	# Unlock next level
	if current_level < TOTAL_LEVELS:
		SaveManager.unlock_level(current_level + 1)

func fail_level() -> void:
	stop_timer()
	level_failed.emit()

func _on_player_died() -> void:
	fail_level()

func restart_level() -> void:
	load_level(current_level)

func load_next_level() -> void:
	if current_level < TOTAL_LEVELS:
		load_level(current_level + 1)

func get_level_time() -> float:
	return level_time

func format_time(time: float) -> String:
	var minutes = int(time) / 60
	var seconds = int(time) % 60
	var milliseconds = int((time - int(time)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, milliseconds]
