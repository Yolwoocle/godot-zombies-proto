extends Weapon
class_name Gun

@export var angle_deviation: float = 0.05
@export var bullet_speed: float = 1000.0
@export var bullet_speed_deviation: float = 100.0

@export_category("Visuals")
@export var bullet_sprite: Texture2D

var _bullet_scn: PackedScene = load("res://scenes/actors/bullet.tscn")
var _rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func attack(_position: Vector2, _direction: Vector2) -> void:
	var bullet = _bullet_scn.instantiate()
	bullet.global_position = _position 
	bullet.direction = _direction.rotated(_rng.randfn(0.0, angle_deviation))
	bullet.speed = bullet_speed + _rng.randfn(bullet_speed, bullet_speed_deviation)
	get_tree().root.add_child(bullet)
