extends Node

var run_depth = 0
var player_moves: Array[Move] = []
var pending_move: Move = null

func add_move(move: Move):
	if player_moves.size() < 4:
		player_moves.append(move)
	else:
		pending_move = move
		get_tree().change_scene_to_file("res://scenes/reward/replace_move_scene.tscn")
