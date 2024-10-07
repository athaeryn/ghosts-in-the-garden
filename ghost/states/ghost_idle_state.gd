class_name GhostIdleState
extends GhostState

@export var defeated_state: GhostDefeatedState

func enter():
	ghost.play_animation("idle")

func process_frame(_delta: float) -> State:
	if ghost.dead:
		return defeated_state
	return null
