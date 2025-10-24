extends Node2D
class_name DebugNode

@export var draw_debug = true

func _ready() -> void:
	if not draw_debug:
		visible = false
