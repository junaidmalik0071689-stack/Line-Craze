extends Area2D
class_name Goal

## Goal/End point - Level completes when player reaches here

@export var requires_all_keys: bool = true

func _ready() -> void:
	add_to_group("goals")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player and body.is_alive:
		# Check if all keys are collected if required
		if requires_all_keys:
			var key_manager = get_tree().get_nodes_in_group("key_manager")
			if key_manager.size() > 0 and key_manager[0].are_all_keys_collected():
				complete_level()
		else:
			complete_level()

func complete_level() -> void:
	LevelManager.complete_level()
