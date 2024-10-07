class_name FrogIdleState
extends FrogState

@export var saved_state: FrogSavedState
@export var hiding_state: FrogHidingState

var back_to_hiding: bool = false

func enter():
	back_to_hiding = false
	frog.play_animation("idle")

func process_frame(_delta: float) -> State:
	if back_to_hiding:
		return hiding_state
	else:
		return null

func on_nearby_exited(_body):
	pass
	#if frog.freed:
		#return
	#if body is Player:
		#frog.sprite.stop()
		#frog.sprite.play_backwards("appear")
		#frog.sprite.animation_finished.connect(_on_hiding_timeout, CONNECT_ONE_SHOT)

func _on_hiding_timeout():
	back_to_hiding = true
