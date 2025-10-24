extends Node2D
class_name Level

@export var number_of_players = 2

var player_tscn: PackedScene = load("res://scenes/actors/player.tscn")
var players: Dictionary[int, Player] = {}

func _ready() -> void:
	_spawn_players()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

###########################################

func add_actor(actor: Node2D):
	add_child(actor)

###########################################

func _spawn_players():
	var player_positions = $PlayerSpawnPositions 
	for i in range(1, number_of_players+1):
		var player: Player = player_tscn.instantiate()
		player.player_index = i
		
		add_actor(player)
		
		var marker: Marker2D = get_node_or_null("PlayerSpawnPositions/" + str(i))
		if marker:
			player.global_position = marker.global_position
		
		players[i] = player
