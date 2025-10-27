# state_machine.gd
class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary = {}


func _ready() -> void:
	_register_states()
	
	if initial_state:
		_change_state(initial_state)
	elif states.size() > 0:
		_change_state(states.values()[0])


func _process(delta: float) -> void:
	if current_state:
		current_state.on_process(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.on_physics_process(delta)


func _register_states() -> void:
	for child in get_children():
		if child is State:
			states[child.get_script()] = child
			child.transition.connect(_on_state_transition)
			child.state_machine = self


func _on_state_transition(target_state_class: GDScript) -> void:
	if target_state_class not in states:
		push_error("State not found: " + str(target_state_class))
		return
	_change_state(states[target_state_class])


func _change_state(new_state: State):
	if current_state:
		current_state.on_exit()
	
	current_state = new_state
	
	if current_state:
		current_state.on_enter()
	
	print("State changed to: " + str(new_state.get_state_name()))
