extends Node

var run_depth = 0
var player_moves: Array[Move] = []
var pending_move: Move = null
var max_player_hp = 30
var player_hp = 30

func reset_run():
	run_depth = 0
	max_player_hp = 30
	player_hp = max_player_hp
	player_moves.clear()
	pending_move = null

func add_move(move: Move):
	if player_moves.size() < 4:
		player_moves.append(move)
	else:
		pending_move = move
		get_tree().change_scene_to_file("res://scenes/reward/replace_move_scene.tscn")
