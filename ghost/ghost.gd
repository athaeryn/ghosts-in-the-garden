class_name Ghost
extends RigidBody2D

@onready var sprite = %AnimatedSprite2D
@onready var state_machine = %StateMachine
@onready var collision_shape_2d = %CollisionShape2D
@onready var animation_player = %AnimationPlayer

@export var idle_state: GhostIdleState
@export var defeated_state: GhostDefeatedState

@onready var audio_stream_player = %AudioStreamPlayer
const GHOST_ATTACK = preload("res://assets/sfx/ghost_attack.mp3")
const GHOST_DEFEATED = preload("res://assets/sfx/ghost_defeated.mp3")

@export var health: int = 100
var dead = false

signal died()

func take_damage(damage: int) -> void:
	health -= damage
	animation_player.play("hurt")
	sfx_attack()
	if health <= 0:
		dead = true
		collision_shape_2d.disabled = true
		
func emit_died():
	died.emit()

func _ready():
	state_machine.init()

func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta):
	state_machine.process_frame(delta)

func play_animation(animation: String) -> void:
	sprite.animation = animation
	if not sprite.is_playing():
		sprite.play(animation)

func sfx_attack():
	audio_stream_player.stream = GHOST_ATTACK
	audio_stream_player.play()

func sfx_defeated():
	audio_stream_player.stream = GHOST_DEFEATED
	audio_stream_player.play()
