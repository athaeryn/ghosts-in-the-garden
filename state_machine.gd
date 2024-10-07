class_name StateMachine
extends Node

@export var initial_state: State
@export var log_prefix: String = ""

var current_state: State

func init() -> void:
	await owner.ready
	change_state(initial_state)

func change_state(new_state: State) -> void:
	if current_state:
		#print(log_prefix, "EXIT ", current_state)
		current_state.exit()
		
	current_state = new_state
	if current_state:
		#print(log_prefix, "ENTER ", current_state)
		current_state.enter()

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state != null:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state != null:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state != null:
		change_state(new_state)
