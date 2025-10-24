extends CharacterBody2D


var speed = 5000.0
var direction: Vector2 = Vector2.RIGHT 

var lifespan = 3.0
var life = 3.0

func _ready() -> void:
	life = lifespan

func _process(delta: float) -> void:
	life -= delta
	if life < 0:
		queue_free()

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	
	move_and_slide()

func _on_hitbox_sent_damage(hurtbox: Hurtbox) -> void:
	queue_free()


func _on_wall_collider_body_entered(body: Node2D) -> void:
	queue_free()
