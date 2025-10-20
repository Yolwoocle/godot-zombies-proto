extends Area2D
class_name Hitbox

@export var damage: float = 1.0
signal sent_damage(area: Hitbox)

func _ready() -> void:
	pass

func on_damage_sent(hurt_box: Hurtbox):
	print("SENT DAMANGE")
	sent_damage.emit(hurt_box)
