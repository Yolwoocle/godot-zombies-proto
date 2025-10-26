extends Area2D

@export var push_speed = 200.0

func _physics_process(delta: float) -> void:
	assert(get_parent() is Actor)
	
	var areas = get_overlapping_areas()
	
	for area in areas:
		var _direction = global_position.direction_to(area.global_position)
		get_parent().velocity += -_direction * push_speed * delta
