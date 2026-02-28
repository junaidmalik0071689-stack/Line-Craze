extends Control

## HUD - Displays game information during gameplay

@onready var timer_label: Label = $MarginContainer/VBoxContainer/TimerLabel
@onready var keys_label: Label = $MarginContainer/VBoxContainer/KeysLabel
@onready var level_label: Label = $MarginContainer/VBoxContainer/LevelLabel

func _ready() -> void:
	LevelManager.timer_updated.connect(_on_timer_updated)
	update_level_display()
	
	# Setup key manager connection
	call_deferred("setup_key_manager")

func setup_key_manager() -> void:
	var managers = get_tree().get_nodes_in_group("key_manager")
	if managers.size() > 0:
		var key_manager = managers[0]
		key_manager.key_collected_update.connect(_on_keys_updated)
		_on_keys_updated(0, key_manager.total_keys)

func _on_timer_updated(time: float) -> void:
	if timer_label:
		timer_label.text = "Time: " + LevelManager.format_time(time)

func _on_keys_updated(collected: int, total: int) -> void:
	if keys_label:
		keys_label.text = "Keys: %d/%d" % [collected, total]

func update_level_display() -> void:
	if level_label:
		level_label.text = "Level: %d" % LevelManager.current_level
