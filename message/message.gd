class_name Message
extends Control

func appear():
	visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.2)

func disappear():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.from_string("#ffffff00", Color.TRANSPARENT), 0.1)
	
func _ready():
	modulate.a = 0
