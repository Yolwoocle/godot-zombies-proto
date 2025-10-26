extends Actor
class_name Player

@export var player_index = 1
@export var weapon: Weapon = null
@export var max_life: float = 5.0
@export var damage_knockback: float = 1000.0

var direction := Vector2.RIGHT

const ACCELERATION = 6000.0
const DECELERATION = 4000.0
const SPEED = 600.0
const INVINCIBILITY_TIME = 2.0

@onready var life_component: LifeComponent = $LifeComponent
@onready var sprite = $Sprite2D

func _ready() -> void:
	super()
	life_component.max_life = max_life
	
	%PlayerIndexLabel.text = "P{0}".format([player_index])

func _process(delta: float) -> void:
	%LifeBar.max_value = max_life
	%LifeBar.value = life_component.life
	%LifeLabel.text = str(life_component.life) + " / " + str(life_component.max_life)
	
	if is_invincible():
		sprite.modulate = Color(1, 1, 1, 0.5 if fmod(life_component.cooldown_value, 0.2) < 0.1 else 1.0)
	else:
		sprite.modulate = Color(1, 1, 1, 1.0)

func _btn(action_name: String) -> String:
	return "game_p{0}_{1}".format([player_index, action_name])

func _physics_process(delta: float) -> void:
	var input_direction := Input.get_vector(_btn("left"), _btn("right"), _btn("up"), _btn("down"))
	if input_direction:
		velocity = velocity.move_toward(input_direction*SPEED, ACCELERATION*delta)
		direction = input_direction.normalized()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION*delta)
	
	if Input.is_action_just_pressed(_btn("attack")):
		_attack(direction)
	
	move_and_slide()

################################################

func _attack(direction: Vector2):
	if weapon:
		weapon.attack(global_position, direction)

################################################

func _on_hurtbox_recieved_damage(area: Hitbox) -> void:
	var impulse = (global_position - area.global_position).normalized() * damage_knockback
	apply_impulse(impulse)

func is_invincible():
	return life_component.is_in_cooldown()
