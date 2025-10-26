# idle_state.gd
class_name IdleState
extends State

@export var player: Player
@export var animated_sprite: AnimatedSprite2D


func on_enter() -> void:
	_play_animation()


func on_exit() -> void:
	_stop_animation()


func on_process(_delta: float) -> void:
	if _is_moving():
		var walk_state = state_machine.get_node("Walk") as WalkState
		if walk_state:
			transit_to(walk_state)


static func _is_moving() -> bool:
	return GameInput.get_input().length() > 0


func _play_animation() -> void:
	if not animated_sprite:
		push_error("State '%s' has no assigned 'AnimatedSprite2D' reference." % get_state_name())
		return
	
	if not player:
		push_error("State '%s' has no assigned 'Player' reference." % get_state_name())
		return
	
	animated_sprite.play(AnimationUtil.get_animation_name("idle", player.current_direction))


func _stop_animation() -> void:
	if not animated_sprite:
		push_error("State '%s' has no assigned 'AnimatedSprite2D' reference." % get_state_name())
		return
	
	animated_sprite.stop()
