extends CharacterBody2D
class_name Actor

const ACTOR_PUSH_SPEED = 300.0

@onready var actor_collision_area = get_node_or_null("ActorCollisionArea")

func _ready() -> void:
	var coll_shape = get_node_or_null("ActorCollisionArea/CollisionShape2D")
	if coll_shape:
		coll_shape.shape.radius = $CollisionShape2D.shape.radius

func apply_impulse(impulse: Vector2):
	velocity += impulse
