extends CanvasLayer
class_name FogSystem

## Fog of War system - Creates visibility limitations around the player

@export var fog_enabled: bool = true
@export var visibility_radius: float = 200.0
@export var fog_color: Color = Color(0, 0, 0, 0.8)

var player: Player = null
var fog_texture: ColorRect = null

func _ready() -> void:
	if not fog_enabled:
		visible = false
		return
	
	setup_fog()

func setup_fog() -> void:
	# Create a dark overlay
	fog_texture = ColorRect.new()
	fog_texture.color = fog_color
	fog_texture.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(fog_texture)
	
	# Create a shader material for the fog effect
	var shader_material = ShaderMaterial.new()
	var shader_code = """
shader_type canvas_item;

uniform vec2 player_position;
uniform float visibility_radius = 200.0;
uniform vec2 screen_size;

void fragment() {
	vec2 pixel_pos = FRAGCOORD.xy;
	float distance = length(pixel_pos - player_position);
	float alpha = smoothstep(visibility_radius - 50.0, visibility_radius + 50.0, distance);
	COLOR.a *= alpha;
}
"""
	
	var shader = Shader.new()
	shader.code = shader_code
	shader_material.shader = shader
	
	fog_texture.material = shader_material

func _process(delta: float) -> void:
	if not fog_enabled or not is_instance_valid(fog_texture):
		return
	
	# Find player if not already found
	if player == null:
		var players = get_tree().get_nodes_in_group("player")
		if players.size() > 0:
			player = players[0]
		return
	
	# Update shader uniforms
	if fog_texture.material is ShaderMaterial:
		var shader_material = fog_texture.material as ShaderMaterial
		var viewport = get_viewport()
		var camera = viewport.get_camera_2d()
		
		if camera:
			var screen_pos = player.global_position - camera.get_screen_center_position() + viewport.get_visible_rect().size / 2
			shader_material.set_shader_parameter("player_position", screen_pos)
			shader_material.set_shader_parameter("visibility_radius", visibility_radius)
			shader_material.set_shader_parameter("screen_size", viewport.get_visible_rect().size)

func set_visibility_radius(radius: float) -> void:
	visibility_radius = radius

func enable_fog() -> void:
	fog_enabled = true
	visible = true

func disable_fog() -> void:
	fog_enabled = false
	visible = false
