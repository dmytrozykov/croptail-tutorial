# animation_util.gd
class_name AnimationUtil

## Returns the animation name string based on a prefix and a direction vector.
## Combines prefix with one of: "front", "back", "left", "right".
static func get_animation_name(prefix: String, direction: Vector2) -> String:
	var anim_name = prefix + "_"
	if abs(direction.x) > abs(direction.y):
		anim_name += "right" if direction.x > 0 else "left"
	else:
		anim_name += "back" if direction.y < 0 else "front"
	return anim_name
