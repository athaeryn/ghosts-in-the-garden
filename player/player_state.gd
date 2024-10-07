class_name PlayerState
extends State

@export var player: Player
@export var animation_name: String = "default"

func enter() -> void:
	player.play_animation(animation_name)

# Return value indicates whether movement happened?
func process_physics_movement(delta: float, movement_multiplier: float = 1.0) -> bool:
	player.directionX = Input.get_axis("move_left", "move_right")
	player.directionY = Input.get_axis("move_up", "move_down")

	var speed = player.SPEED * movement_multiplier

	var velo_x = player.directionX * speed * 100 * delta
	var velo_y = player.directionY * speed * 100 * delta
	var target_v = Vector2(velo_x, velo_y)
	
	player.velocity = target_v

	var collided = player.move_and_slide()

	if collided:
		var collision = player.get_last_slide_collision()
		if collision != null:
			var normal = collision.get_normal()
			player.position += normal
			
			var collider = collision.get_collider()
			if collider is Ghost:
				#print("OOF OUCH")
				pass
			
	player.position = player.position.round()

	if player.velocity.length_squared() == 0 and not collided:
		return true
	else:
		return false
	
func get_is_attacking() -> bool:
	var attack_up: bool = Input.is_action_pressed("attack_up")
	var attack_down: bool = Input.is_action_pressed("attack_down")
	var attack_left: bool = Input.is_action_pressed("attack_left")
	var attack_right: bool = Input.is_action_pressed("attack_right")
	
	return attack_up or attack_down or attack_left or attack_right
	
func get_is_moving() -> bool:
	var move_up: bool = Input.is_action_pressed("move_up")
	var move_down: bool = Input.is_action_pressed("move_down")
	var move_left: bool = Input.is_action_pressed("move_left")
	var move_right: bool = Input.is_action_pressed("move_right")
	
	return move_up or move_down or move_left or move_right

func get_attack_direction() -> PlayerAttackingState.Direction:
	var attack_up: bool = Input.is_action_pressed("attack_up")
	var attack_down: bool = Input.is_action_pressed("attack_down")
	var attack_left: bool = Input.is_action_pressed("attack_left")
	var attack_right: bool = Input.is_action_pressed("attack_right")
	
	if attack_up:
		return PlayerAttackingState.Direction.Up
	else: if attack_down:
		return PlayerAttackingState.Direction.Down
	else: if attack_left:
		return PlayerAttackingState.Direction.Left
	else: if attack_right:
		return PlayerAttackingState.Direction.Right
	
	return PlayerAttackingState.Direction.Down
