extends Node

## Save Manager - Handles game progress saving and loading

const SAVE_FILE_PATH = "user://line_craze_save.json"
const TOTAL_LEVELS = 60

var save_data: Dictionary = {
	"unlocked_levels": [1],  # Level 1 is always unlocked
	"completed_levels": {},   # level_number: best_time
	"current_level": 1
}

func _ready() -> void:
	load_game()

func save_game() -> void:
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()
	else:
		push_error("Failed to save game data")

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		# First time playing, initialize with defaults
		save_game()
		return
	
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		
		if parse_result == OK:
			var loaded_data = json.get_data()
			if typeof(loaded_data) == TYPE_DICTIONARY:
				save_data = loaded_data
		else:
			push_error("Failed to parse save file")
	else:
		push_error("Failed to load game data")

func unlock_level(level_number: int) -> void:
	if level_number < 1 or level_number > TOTAL_LEVELS:
		return
	
	if level_number not in save_data["unlocked_levels"]:
		save_data["unlocked_levels"].append(level_number)
		save_data["unlocked_levels"].sort()
		save_game()

func is_level_unlocked(level_number: int) -> bool:
	return level_number in save_data["unlocked_levels"]

func complete_level(level_number: int, time: float) -> void:
	# Update best time if this is better or first completion
	if not save_data["completed_levels"].has(str(level_number)):
		save_data["completed_levels"][str(level_number)] = time
	else:
		var current_best = save_data["completed_levels"][str(level_number)]
		if time < current_best:
			save_data["completed_levels"][str(level_number)] = time
	
	save_data["current_level"] = level_number
	save_game()

func is_level_completed(level_number: int) -> bool:
	return save_data["completed_levels"].has(str(level_number))

func get_level_best_time(level_number: int) -> float:
	if save_data["completed_levels"].has(str(level_number)):
		return save_data["completed_levels"][str(level_number)]
	return 0.0

func get_unlocked_levels() -> Array:
	return save_data["unlocked_levels"]

func get_completed_levels_count() -> int:
	return save_data["completed_levels"].size()

func reset_progress() -> void:
	save_data = {
		"unlocked_levels": [1],
		"completed_levels": {},
		"current_level": 1
	}
	save_game()

func get_current_level() -> int:
	return save_data["current_level"]
