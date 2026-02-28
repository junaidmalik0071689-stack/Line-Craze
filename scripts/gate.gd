extends StaticBody2D
class_name Gate

## Gate unlock script
## Gates block the path until all keys are collected

@export var keys_required: int = 0
@export var open_automatically: bool = true

var is_open: bool = false
var key_manager: KeyManager = null

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D if has_node("Sprite2D") else null

func _ready() -> void:
	add_to_group("gates")
	
	# Find or create key manager
	if open_automatically:
		call_deferred("setup_key_manager")

func setup_key_manager() -> void:
	var managers = get_tree().get_nodes_in_group("key_manager")
	if managers.size() > 0:
		key_manager = managers[0]
		key_manager.all_keys_collected.connect(_on_all_keys_collected)
	
	# Check if keys are already collected
	if key_manager and key_manager.are_all_keys_collected():
		open_gate()

func _on_all_keys_collected() -> void:
	open_gate()

func open_gate() -> void:
	if is_open:
		return
	
	is_open = true
	
	# Disable collision
	if collision_shape:
		collision_shape.set_deferred("disabled", true)
	
	# Visual feedback
	if sprite:
		var tween = create_tween()
		tween.tween_property(sprite, "modulate:a", 0.3, 0.5)

func close_gate() -> void:
	if not is_open:
		return
	
	is_open = false
	
	# Enable collision
	if collision_shape:
		collision_shape.set_deferred("disabled", false)
	
	# Visual feedback
	if sprite:
		sprite.modulate.a = 1.0

func can_player_pass(player: Player) -> bool:
	if is_open:
		return true
	
	if keys_required > 0:
		return player.get_keys_collected() >= keys_required
	
	return false
