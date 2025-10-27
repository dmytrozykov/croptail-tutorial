# tool_resource.gd
class_name ToolResource
extends Resource

@export var name: String
@export var animation_prefix: String
@export var action_script: Script


func activate(wielder: Node) -> void:
	if not action_script:
		push_warning("Tool resource '%s' has no action script." % name)
		return
	
	var instance = action_script.new()
	if instance.has_method("activate"):
		instance.activate(wielder)
	else:
		push_warning("Tool resource '%s' action script has no method 'activate'" % name)
