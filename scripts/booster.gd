extends Area2D
class_name Booster

## Booster system - Provides temporary speed boost to player

@export var boost_duration: float = 5.0
@export var boost_type: String = "speed"  # speed, invincibility, etc.

signal collected

func _ready() -> void:
	add_to_group("boosters")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		apply_boost(body)

func apply_boost(player: Player) -> void:
	match boost_type:
		"speed":
			player.apply_speed_boost(boost_duration)
	
	collected.emit()
	queue_free()
