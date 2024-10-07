extends Camera2D

@export var player: Player

var game_size: Vector2i = Vector2i(640, 630)

@onready var window_scale: float = (DisplayServer.window_get_size() / game_size).x

@onready var actual_camera_pos := global_position

func _process(delta: float) -> void:
	var camera_position = player.global_position
	actual_camera_pos = lerp(actual_camera_pos, camera_position, delta*5)
	var subpixel_position = actual_camera_pos.round() - actual_camera_pos
	Global.viewport_container.material.set_shader_parameter("cam_offset", subpixel_position)
	global_position = actual_camera_pos.round()
