extends CharacterBody2D
class_name Player

## Player movement script for Line Craze
## Handles ball movement from start to end point

@export var speed: float = 300.0
@export var acceleration: float = 1500.0
@export var friction: float = 1200.0

var keys_collected: int = 0
var is_alive: bool = true
var has_speed_boost: bool = false
var boost_multiplier: float = 1.5
var boost_timer: float = 0.0

signal player_died
signal key_collected(total_keys: int)
signal reached_goal

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if not is_alive:
		return
	
	# Handle boost timer
	if has_speed_boost:
		boost_timer -= delta
		if boost_timer <= 0:
			has_speed_boost = false
	
	# Get input direction
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Apply movement
	if input_direction != Vector2.ZERO:
		var target_speed = speed * (boost_multiplier if has_speed_boost else 1.0)
		velocity = velocity.move_toward(input_direction * target_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()

func collect_key() -> void:
	keys_collected += 1
	key_collected.emit(keys_collected)

func apply_speed_boost(duration: float) -> void:
	has_speed_boost = true
	boost_timer = duration

func die() -> void:
	if is_alive:
		is_alive = false
		velocity = Vector2.ZERO
		player_died.emit()

func reset() -> void:
	is_alive = true
	keys_collected = 0
	velocity = Vector2.ZERO
	has_speed_boost = false
	boost_timer = 0.0

func get_keys_collected() -> int:
	return keys_collected
