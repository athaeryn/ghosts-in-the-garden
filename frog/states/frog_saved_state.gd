class_name FrogSavedState
extends FrogState

func enter():
	frog.play_animation("jump")
	frog.sprite.animation_finished.connect(_jump_finished, CONNECT_ONE_SHOT)

func _jump_finished():
	frog.play_animation("saved_idle")
