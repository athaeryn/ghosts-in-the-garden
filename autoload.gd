extends Node

var viewport_container: SubViewportContainer = null
var viewport: SubViewport = null

func set_camera_subpixel_position(pos: Vector2) -> void:
	if viewport_container == null:
		return
	var material : ShaderMaterial = viewport_container.material
	material.set_shader_parameter("cam_offset", pos)
