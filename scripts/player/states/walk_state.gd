# walk_state.gd
class_name WalkState
extends State

@export var player: Player
@export var animated_sprite: AnimatedSprite2D
@export var move_speed: float = 50.0


func on_enter() -> void:
	_play_animation()


func on_exit() -> void:
	_stop_animation()


func on_physics_process(_delta: float) -> void:
	if not player:
		push_error("State '%s' has no assigned 'Player' reference." % get_state_name())
		return
	
	var new_direction = GameInput.get_input()
	
	if new_direction.length() == 0:
		_transit_to_idle()
		return
	
	if new_direction != player.current_direction:
		player.current_direction = new_direction
		_play_animation()
	
	_move_character()


func _move_character() -> void:
	if not player:
		push_error("State '%s' has no assigned 'Player' reference." % get_state_name())
		return

	player.velocity = player.current_direction * move_speed
	player.move_and_slide()


func _transit_to_idle() -> void:
	var idle_state = state_machine.get_node("Idle") as IdleState
	if idle_state:
		transit_to(idle_state)


func _play_animation() -> void:
	if not animated_sprite:
		push_error("State '%s' has no assigned 'AnimatedSprite2D' reference." % get_state_name())
		return
	
	if not player:
		push_error("State '%s' has no assigned 'Player' reference." % get_state_name())
		return
	
	animated_sprite.play(AnimationUtil.get_animation_name("walk", player.current_direction))


func _stop_animation() -> void:
	if not animated_sprite:
		push_error("State '%s' has no assigned 'AnimatedSprite2D' reference." % get_state_name())
		return
	
	animated_sprite.stop()
