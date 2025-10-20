extends CharacterBody2D

@export var gun: Gun = null
@export var max_life: float = 5.0

const ACCELERATION = 6000.0
const DECELERATION = 4000.0
const SPEED = 600.0
const INVINCIBILITY_TIME = 2.0

@onready var life_component: LifeComponent = $LifeComponent
@onready var sprite = $Sprite2D

func _ready() -> void:
	life_component.max_life = max_life

func _process(delta: float) -> void:
	%LifeBar.max_value = max_life
	%LifeBar.value = life_component.life
	%LifeLabel.text = str(life_component.life) + " / " + str(life_component.max_life)
	
	if is_invincible():
		sprite.modulate = Color(1, 1, 1, 0.5 if fmod(life_component.cooldown_value, 0.2) < 0.1 else 1.0)
	else:
		sprite.modulate = Color(1, 1, 1, 1.0)

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("game_left", "game_right", "game_up", "game_down")
	if direction:
		velocity = velocity.move_toward(direction*SPEED, ACCELERATION*delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION*delta)
	
	if Input.is_action_just_pressed("game_shoot"):
		var dir = (get_global_mouse_position() - global_position).normalized()
		_shoot(dir)
	
	move_and_slide()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	damage_self(1.0)

################################################

func _shoot(direction: Vector2):
	if gun:
		gun.shoot(global_position, direction)

################################################

func is_invincible():
	return life_component.is_in_cooldown()

func damage_self(amount: float):
	if is_invincible():
		return
	life_component.damage(1.0)
