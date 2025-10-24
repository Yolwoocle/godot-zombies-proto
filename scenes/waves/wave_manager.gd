extends Node2D

enum EnemyTypes {
	NORMAL
}

var waves = [
	{
		enemies = [
			{type = EnemyTypes.NORMAL, portal = "1", delay = 0},
			{type = EnemyTypes.NORMAL, portal = "2", delay = 1.0},
			{type = EnemyTypes.NORMAL, portal = "3", delay = 1.0},
			{type = EnemyTypes.NORMAL, portal = "4", delay = 1.0},
			{type = EnemyTypes.NORMAL, portal = "5", delay = 1.0},
			{type = EnemyTypes.NORMAL, portal = "6", delay = 1.0},
			
			{type = EnemyTypes.NORMAL, portal = "1", delay = 1.0},
			{type = EnemyTypes.NORMAL, portal = "2", delay = 1.0},
			{type = EnemyTypes.NORMAL, portal = "3", delay = 1.0},
			{type = EnemyTypes.NORMAL, portal = "4", delay = 1.0},
			{type = EnemyTypes.NORMAL, portal = "5", delay = 1.0},
			{type = EnemyTypes.NORMAL, portal = "6", delay = 1.0},
			
			{type = EnemyTypes.NORMAL, portal = "1", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "2", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "3", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "4", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "5", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "6", delay = 5.0},
			
			{type = EnemyTypes.NORMAL, portal = "1", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "2", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "3", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "4", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "5", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "6", delay = 5.0},
			
			{type = EnemyTypes.NORMAL, portal = "1", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "2", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "3", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "4", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "5", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "6", delay = 5.0},
			
			{type = EnemyTypes.NORMAL, portal = "1", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "2", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "3", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "4", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "5", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "6", delay = 5.0},
			
			{type = EnemyTypes.NORMAL, portal = "1", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "2", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "3", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "4", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "5", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "6", delay = 5.0},
			
			{type = EnemyTypes.NORMAL, portal = "1", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "2", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "3", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "4", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "5", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "6", delay = 5.0},
			
			{type = EnemyTypes.NORMAL, portal = "1", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "2", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "3", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "4", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "5", delay = 5.0},
			{type = EnemyTypes.NORMAL, portal = "6", delay = 5.0},
		]
	},
	{
		enemies = [
			{type = EnemyTypes.NORMAL, portal = "1", delay = 0.3},
			{type = EnemyTypes.NORMAL, portal = "3", delay = 0.3},
			{type = EnemyTypes.NORMAL, portal = "6", delay = 0.3},
			{type = EnemyTypes.NORMAL, portal = "4", delay = 0.3},
		]
	}
]

var portals: Dictionary[String, Marker2D] = {}
var wave_timer = 0.0

var current_wave_i = 0
var current_wave = null

var current_enemy_set_i: int = 0
var current_enemy_set = null

func _ready() -> void:
	for child in get_children():
		if child is Marker2D:
			portals[child.name] = child
	
	set_wave(0)
	wave_timer = current_enemy_set.delay

func _process(delta: float) -> void:
	$"../Label".text = "Wave {0} / Enemy set {1} / {2}s".format([current_wave_i, current_enemy_set_i, wave_timer])
	
	if current_wave:
		wave_timer -= delta
		if wave_timer < 0.0:
			var limit = 100
			while limit > 0 and wave_timer < 0.0:
				_spawn_enemy_set(current_enemy_set)
				_next_enemy_set()
				limit -= 1

func set_wave(wave: int):
	current_wave_i = wave
	if wave < 0 or waves.size() <= wave:
		current_wave = null
	else:
		current_wave = waves[wave]
	set_enemy_set(0)

func set_enemy_set(index: int):
	current_enemy_set_i = index
	if not current_wave:
		current_enemy_set = null
		return
	
	if index < 0 or current_wave.enemies.size() <= index:
		current_enemy_set = null
		return
	
	current_enemy_set = current_wave.enemies[index]

##############################################

func _next_enemy_set():
	set_enemy_set(current_enemy_set_i + 1)
	if current_enemy_set:
		wave_timer = current_enemy_set.delay

func _spawn_enemy_set(enemy_set):
	if not enemy_set:
		return
	var enemy_tscn = Play.get_enemy_packed_scene(enemy_set.type)
	var portal = portals[enemy_set.portal]
	
	var enemy = enemy_tscn.instantiate()
	Play.new_actor(enemy, portal.global_position)
