extends Area2D
class_name Hitbox

@export var damage: float = 1.0
signal sent_damage(hurtbox: Hurtbox)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var areas = get_overlapping_areas()
	
	for area in areas:
		if area is Hurtbox and area.is_hittable(self):
			var hurtbox = area as Hurtbox
			hurtbox.on_recieve_damage(self)
			sent_damage.emit(hurtbox)
