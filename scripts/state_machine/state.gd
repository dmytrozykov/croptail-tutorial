# state.gd
class_name State
extends Node

## Signal emitted when a state requests a transition to another state.
@warning_ignore("unused_signal")
signal transition(target_state_class: GDScript)

var state_machine: StateMachine

## Called every frame by the owning StateMachine for custom per-frame logic.
@warning_ignore("unused_parameter")
func on_process(delta: float) -> void:
	pass


## Called every physics frame by the owning StateMachine for physics-related logic.
@warning_ignore("unused_parameter")
func on_physics_process(delta: float) -> void:
	pass


## Called when the state is entered.
func on_enter() -> void:
	pass


## Called when the state is exited.
func on_exit() -> void:
	pass


## Requests a transition to another state.
## Emits the `transition` signal with the target state's script class.
func transit_to(target_state: State) -> void:
	transition.emit(target_state.get_script())


## Returns the global class name of this state script.
func get_state_name() -> String:
	return get_script().get_global_name()
