extends Node2D
class_name Gun

@export var gun_params: GunParams

var _bullet_scn: PackedScene = load("res://scenes/bullet.tscn")
var _rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func shoot(_position: Vector2, _direction: Vector2):
	var bullet = _bullet_scn.instantiate()
	bullet.global_position = _position 
	bullet.direction = _direction.rotated(_rng.randfn(0.0, gun_params.angle_deviation))
	bullet.speed = gun_params.bullet_speed + _rng.randfn(gun_params.bullet_speed, gun_params.bullet_speed_deviation)
	get_tree().root.add_child(bullet)
