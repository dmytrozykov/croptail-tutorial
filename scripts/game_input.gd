# game_input.gd
class_name GameInput

## Returns a normalized input vector based on defined input actions.
## Reads the "walk_left", "walk_right", "walk_up", and "walk_down" actions.
static func get_input() -> Vector2:
	return Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")


static func primary_action() -> bool:
	return Input.is_action_just_pressed("primary_action")
