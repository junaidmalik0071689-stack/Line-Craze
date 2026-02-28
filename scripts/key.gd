extends Area2D
class_name Key

## Key collectible script
## Player collects keys to unlock gates

signal collected

func _ready() -> void:
	add_to_group("keys")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		collect(body)

func collect(player: Player) -> void:
	player.collect_key()
	collected.emit()
	queue_free()
