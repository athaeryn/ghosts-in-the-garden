class_name PlayerRunningState
extends PlayerState

@export var attacking_state: PlayerAttackingState
@export var idle_state: PlayerIdleState

@export var up_animation_name: String
@export var down_animation_name: String
@export var side_animation_name: String

func process_frame(_delta) -> State:
	if abs(Input.get_axis("move_left", "move_right")) > 0.5:
		player.sprite.animation = side_animation_name
	else: if Input.get_axis("move_up", "move_down") >= 0:
		player.sprite.animation = down_animation_name
	else:
		player.sprite.animation = up_animation_name

	if player.directionX < 0:
		player.sprite.flip_h = true
	else:
		player.sprite.flip_h = false
	return null

func exit():
	player.sprite.flip_h = false

func process_physics(delta) -> State:
	if get_is_attacking():
		player.attack_direction = get_attack_direction()
		return attacking_state
		
	var idle = process_physics_movement(delta)

	return idle_state if idle else null
