extends CharacterBody2D
class_name Enemy

## Enemy chase script for Line Craze
## Enemies chase the player and cause death on contact

@export var chase_speed: float = 200.0
@export var detection_radius: float = 400.0
@export var patrol_speed: float = 100.0
@export var patrol_points: Array[Vector2] = []

var player: Player = null
var current_patrol_index: int = 0
var is_chasing: bool = false

func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	# Find player if not already found
	if player == null:
		var players = get_tree().get_nodes_in_group("player")
		if players.size() > 0:
			player = players[0]
		return
	
	# Check if player is alive
	if not player.is_alive:
		is_chasing = false
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	# Calculate distance to player
	var distance_to_player = global_position.distance_to(player.global_position)
	
	# Chase or patrol
	if distance_to_player <= detection_radius:
		chase_player(delta)
	else:
		patrol(delta)
	
	move_and_slide()

func chase_player(delta: float) -> void:
	is_chasing = true
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * chase_speed

func patrol(delta: float) -> void:
	is_chasing = false
	
	if patrol_points.size() == 0:
		velocity = Vector2.ZERO
		return
	
	var target_point = patrol_points[current_patrol_index]
	var direction = (target_point - global_position).normalized()
	var distance = global_position.distance_to(target_point)
	
	if distance < 10.0:
		current_patrol_index = (current_patrol_index + 1) % patrol_points.size()
	else:
		velocity = direction * patrol_speed

func _on_body_entered(body: Node2D) -> void:
	if body is Player and body.is_alive:
		body.die()
