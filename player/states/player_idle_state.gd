class_name PlayerIdleState
extends PlayerState

@export var running_state: PlayerRunningState
@export var attacking_state: PlayerAttackingState

func process_frame(_delta: float) -> State:
	if get_is_attacking():
		player.attack_direction = get_attack_direction()
		return attacking_state

	if get_is_moving():
		return running_state

	return null
