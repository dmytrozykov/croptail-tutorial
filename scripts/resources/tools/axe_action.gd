# axe_action.gd
extends ToolAction

func activate(wielder: Node) -> void:
	print("Axe activated by '%s'" % wielder.name)
