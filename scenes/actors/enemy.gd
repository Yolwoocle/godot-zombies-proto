extends CharacterBody2D
class_name Enemy

@export var target: Player

@export var vision_range = 600
@export var lose_vision_range = 800

const ACCELERATION = 400.0
const DECELERATION = 600.0
const SPEED = 200.0
const ACTOR_PUSH_SPEED = 100.0

var direction = Vector2.ZERO

@onready var life_component = $LifeComponent
@onready var navigation_agent = $NavigationAgent2D
@onready var vision_area = $VisionArea
@onready var actor_collision_area = $ActorCollisionArea

func _ready() -> void:
	$VisionArea/CollisionShape2D.shape.radius = vision_range
	$ActorCollisionArea/CollisionShape2D.shape.radius = $CollisionShape2D.shape.radius

func _physics_process(delta: float) -> void:
	_push_away_from_other_actors(delta)
	_follow_target(delta)
	
	move_and_slide()

func _process(_delta: float) -> void:
	%LifeBar.max_value = life_component.max_life
	%LifeBar.value = life_component.life
	%LifeLabel.text = str(life_component.life) + " / " + str(life_component.max_life)
	
	_update_target()
	
	$HUD/Label.text = str(target.name) if target else "no target"

###################################

func _push_away_from_other_actors(delta: float):
	var areas = actor_collision_area.get_overlapping_areas()
	print(areas)
	
	for area in areas:
		var _direction = global_position.direction_to(area.global_position)
		velocity = velocity.move_toward(-_direction * ACTOR_PUSH_SPEED, ACCELERATION * delta) 

func _update_target():
	# Check if current target still within range
	if target:
		if target.global_position.distance_squared_to(global_position) > lose_vision_range**2:
			_stop_targeting()
		return
	
	_find_new_target()

func _find_new_target():
	var candidates = vision_area.get_overlapping_bodies()
	
	var closest_candidate = null
	var closest_candidate_dist = INF
	for candidate: Node2D in candidates:
		var dist_sq = candidate.global_position.distance_squared_to(global_position)
		if dist_sq < closest_candidate_dist:
			closest_candidate = candidate
			closest_candidate_dist = dist_sq
	
	if closest_candidate:
		_start_targeting(closest_candidate)

func _start_targeting(new_target: Node2D):
	target = new_target

func _stop_targeting():
	target = null

func _follow_target(delta: float) -> void:
	if target:
		navigation_agent.target_position = target.global_position
		
		var _direction = navigation_agent.get_next_path_position() - global_position
		_direction = _direction.normalized()
		
		velocity = velocity.move_toward(_direction * SPEED, ACCELERATION * delta) 
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta) 


func _on_life_component_died() -> void:
	queue_free()
