class_name PlayerAttackingState
extends PlayerState

@export var idle_state: PlayerIdleState
@export var running_state: PlayerRunningState

@onready var sprite = %AnimatedSprite2D

@export var up_animation_name: String
@export var down_animation_name: String
@export var side_animation_name: String

@onready var up_hurtbox = %UpHurtbox
@onready var right_hurtbox = %RightHurtbox
@onready var left_hurtbox = %LeftHurtbox
@onready var down_hurtbox = %DownHurtbox

const ATTACK_FRAME: int = 3

enum Direction {
	Up,
	Down,
	Left,
	Right
}

func play_punch_sfx():
	player.audio_stream_player.stream = player.PLAYER_PUNCH
	player.audio_stream_player.play()

func enter():
	match player.attack_direction:
		Direction.Up:
			animation_name = up_animation_name
		Direction.Down:
			animation_name = down_animation_name
		Direction.Left:
			player.sprite.flip_h = true
			animation_name = side_animation_name
		Direction.Right:
			animation_name = side_animation_name
	super()
	play_punch_sfx()

func exit():
	player.sprite.flip_h = false
	super()
	
func process_physics(delta) -> State:
	process_physics_movement(delta, 0.35)
	
	return null

func process_frame(_delta: float) -> State:
	if player.sprite.frame == ATTACK_FRAME:
		match player.attack_direction:
			PlayerAttackingState.Direction.Up:
				if up_hurtbox.has_overlapping_bodies():
					assign_damage(up_hurtbox)
			PlayerAttackingState.Direction.Down:
				if down_hurtbox.has_overlapping_bodies():
					assign_damage(down_hurtbox)
			PlayerAttackingState.Direction.Left:
				if left_hurtbox.has_overlapping_bodies():
					assign_damage(left_hurtbox)
			PlayerAttackingState.Direction.Right:
				if right_hurtbox.has_overlapping_bodies():
					assign_damage(right_hurtbox)
		
	if not player.sprite.is_playing():
		if player.velocity.length_squared() > 0:
			return running_state
		else:
			return idle_state
	return null

func assign_damage(hurtbox: Area2D) -> void:
	var overlapping = hurtbox.get_overlapping_bodies()
	for body in overlapping:
		if body.has_method("take_damage"):
			body.take_damage(1)
			if body is RigidBody2D:
				var body_position: Vector2 = body.position
				var player_position: Vector2 = player.position
				var impulse: Vector2 = player_position.direction_to(body_position)
				var distance = player_position.distance_to(body_position)
				var strength = clamp(remap(distance, 50, 100, 1, 0.25), 0, 1)
				impulse *= 300 * strength
				body.apply_impulse(impulse)
