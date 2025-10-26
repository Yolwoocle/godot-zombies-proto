extends Camera2D

@export var shake_decrease_speed: float = 100.0
@export var kick_decrease_speed: float = 400.0

var current_shake: float = 0.0

var current_kick: Vector2 = Vector2.ZERO
 
var _rng = RandomNumberGenerator.new()

func _process(delta: float) -> void:
	var _shake = _rng.randf_range(0, current_shake) * Vector2.RIGHT.rotated(_rng.randf_range(0, TAU))
	current_shake = max(0.0, current_shake - shake_decrease_speed * delta)
	
	current_kick = current_kick.move_toward(Vector2.ZERO, kick_decrease_speed * delta)
	
	offset = _shake + current_kick

func shake(amount: float) -> void:
	current_shake = max(current_shake, amount)

func kick(impulse: Vector2) -> void:
	current_kick += impulse

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if not event.is_pressed():
			#return
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#print("KICK ", get_global_mouse_position())
			#kick(get_global_mouse_position() / 10)
		#elif event.button_index == MOUSE_BUTTON_RIGHT:
			#print("SHAKE ", get_global_mouse_position().x)
			#shake(get_global_mouse_position().x / 10)
