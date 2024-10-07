class_name Frog
extends Node2D

@onready var state_machine: StateMachine = %StateMachine
@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

@export var hiding_state: FrogHidingState
@export var idle_state: FrogIdleState
@export var saved_state: FrogSavedState

var freed = false

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

func set_free() -> void:
	freed = true
	state_machine.change_state(saved_state)

func _on_nearby_detector_body_entered(body):
	state_machine.current_state.on_nearby_entered(body)

func _on_nearby_detector_body_exited(body):
	state_machine.current_state.on_nearby_exited(body)
