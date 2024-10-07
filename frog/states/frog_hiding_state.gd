class_name FrogHidingState
extends FrogState

@export var idle_state: FrogIdleState

var ready_to_idle: bool = false

func enter():
	ready_to_idle = false
	frog.sprite.animation = "appear"
	frog.sprite.stop()

func process_frame(_delta: float) -> State:
	return idle_state if ready_to_idle else null


func on_nearby_entered(body):
	if body is Player:
		frog.play_animation("appear")
		frog.sprite.animation_finished.connect(_on_appear_finished, CONNECT_ONE_SHOT)

func _on_appear_finished():
	ready_to_idle = true
