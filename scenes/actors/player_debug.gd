extends DebugNode


func _process(_delta):
	queue_redraw()

# Called when the node enters the scene tree for the first time.
func _draw():
	if not draw_debug:
		return
	var parent: Player = get_parent()
	draw_line(Vector2.ZERO, parent.direction *100, Color.YELLOW, 1.0)
