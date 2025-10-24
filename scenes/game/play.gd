extends Node2D

enum EnemyType {
	NORMAL
}

var levels: Dictionary[String, PackedScene] = {
	"0": load("res://scenes/game/level.tscn")
}

var _enemy_type_to_scene: Dictionary[EnemyType, PackedScene] = {
	EnemyType.NORMAL: load("res://scenes/actors/enemy.tscn"), 
}

func get_enemy_packed_scene(enemy_type: EnemyType) -> PackedScene:
	assert(_enemy_type_to_scene.has(enemy_type))
	return _enemy_type_to_scene[enemy_type]

func load_level(level_name: String) -> void:
	assert(levels.has(level_name))
	var level = levels[level_name]
	get_tree().change_scene_to_packed(level)

func new_actor(node: Node2D, new_global_position: Vector2 = Vector2.INF) -> void:
	var level = get_tree().current_scene
	if level is not Level:
		return
	
	level.add_actor(node)
	if new_global_position.is_finite():
		node.global_position = new_global_position
