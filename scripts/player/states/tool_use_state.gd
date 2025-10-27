# tool_use_state.gd
class_name ToolUseState
extends State

@export var player: Player
@export var animated_sprite: AnimatedSprite2D


func on_enter() -> void:
	_play_animation()


func on_exit() -> void:
	_activate_tool()
	_stop_animation()


func on_process(_delta: float) -> void:
	if not animated_sprite:
		push_error("State '%s' has no assigned 'AnimatedSprite2D' reference." % get_state_name())
		return
	
	if !animated_sprite.is_playing():
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
	
	if not player.current_tool:
		push_error("'Player' has not current tool.")
		return
	
	animated_sprite.play(AnimationUtil.get_animation_name(player.current_tool.animation_prefix, player.current_direction))


func _stop_animation() -> void:
	if not animated_sprite:
		push_error("State '%s' has no assigned 'AnimatedSprite2D' reference." % get_state_name())
		return
	
	animated_sprite.stop()


func _activate_tool() -> void:
	if not player:
		push_error("State '%s' has no assigned 'Player' reference." % get_state_name())
		return
	
	if not player.current_tool:
		push_error("'Player' has not current tool.")
		return
	player.current_tool.activate(player)
