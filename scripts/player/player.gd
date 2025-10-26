# player.gd
class_name Player
extends CharacterBody2D

@export var current_tool: ToolResource

var current_direction: Vector2 = Vector2.DOWN
