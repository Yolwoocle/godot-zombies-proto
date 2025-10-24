extends DebugNode

func _draw():
	if not draw_debug:
		return
	var parent = get_parent()
	draw_circle(Vector2.ZERO, parent.vision_range, Color.GREEN, false)
	draw_circle(Vector2.ZERO, parent.lose_vision_range, Color.GREEN, false)
