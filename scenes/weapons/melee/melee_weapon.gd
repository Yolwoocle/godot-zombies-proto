extends Weapon
class_name MeleeWeapon

@export var damage := 1.0
@export var range := 64.0
@export_range(0, 10, 0.05, "or_greater", "suffit:s") var attack_duration := 0.1
@export_range(0, 10, 0.05, "or_greater", "suffit:s") var cooldown := 0.5

@onready var hitbox = $Hitbox
@onready var hitbox_collision_shape = $Hitbox/CollisionShape2D
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var attack_timer: Timer = $AttackTimer
@onready var sprite = $Sprite2D

func _ready() -> void:
	hitbox_collision_shape.disabled = true
	sprite.visible = false
	
	attack_timer.wait_time = attack_duration
	attack_timer.timeout.connect(func():
		hitbox_collision_shape.disabled = false
		sprite.visible = false
	)
	
	cooldown_timer.wait_time = cooldown

func attack(_position: Vector2, _direction: Vector2) -> void:
	if not cooldown_timer.is_stopped():
		return
	
	rotation = _direction.angle()
	
	cooldown_timer.start(cooldown)
	sprite.visible = true
	hitbox_collision_shape.disabled = false
	
	cooldown_timer.start()
	attack_timer.start()
