class_name Player
extends CharacterBody2D

@onready var state_machine: StateMachine = %StateMachine
@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

@onready var audio_stream_player = %AudioStreamPlayer
const PLAYER_PUNCH = preload("res://assets/sfx/player_punch.mp3")

@export var idle_state: PlayerIdleState
@export var running_state: PlayerRunningState
@export var attacking_state: PlayerAttackingState

const ONE_SHOT: int = 4

@export var SPEED: float = 2000.0

var directionX: float = 0
var directionY: float = 0

var attack_direction: PlayerAttackingState.Direction = PlayerAttackingState.Direction.Down

func _ready():
	%StateMachine.init()
	
func _physics_process(delta):
	%StateMachine.process_physics(delta)

func play_animation(animation: String) -> void:
	sprite.animation = animation
	if not sprite.is_playing():
		sprite.play(animation)
		
func _process(delta):
	%StateMachine.process_frame(delta)
