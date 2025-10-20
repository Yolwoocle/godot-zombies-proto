extends Area2D
class_name Hurtbox

@export var life_component: LifeComponent
## Whether to ignore sibling hitboxes 
@export var ignore_self_hitboxes := true
signal recieved_damage(area: Hitbox)

func _ready() -> void:
	assert(life_component != null, "No life component defined for hurtbox")

func _process(delta: float) -> void:
	var areas = get_overlapping_areas()
	
	for area in areas:
		if area is Hitbox and _can_hit_self(area):
			recieved_damage.emit(area)
			area.on_damage_sent(self)
			
			assert(life_component != null, "No life component defined for hurtbox")
			life_component.damage(area.damage)

func _can_hit_self(hitbox: Hitbox):
	if ignore_self_hitboxes and hitbox.get_parent() == get_parent():
		return false
	return true
