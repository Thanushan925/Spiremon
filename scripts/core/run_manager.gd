extends Node

var run_depth = 0
var player_moves: Array[Move] = []
var pending_move: Move = null
var max_player_hp = 30
var player_hp = 30
var map_message = ""

func reset_run():
	run_depth = 0
	max_player_hp = 30
	player_hp = max_player_hp
	player_moves.clear()
	pending_move = null
	map_message = ""

func set_map_message(message: String):
	map_message = message

func consume_map_message() -> String:
	var message = map_message
	map_message = ""
	return message
	
func build_heal_message(current_hp: int, max_hp: int) -> String:
	return "Healed to full HP: " + str(current_hp) + "/" + str(max_hp)

func build_learned_move_message(move_name: String) -> String:
	return "Learned move: " + move_name

func build_skipped_reward_message() -> String:
	return "Skipped reward."

func build_replaced_move_message(old_move_name: String, new_move_name: String) -> String:
	return "Replaced " + old_move_name + " with " + new_move_name

func build_recruited_spiremon_message(spiremon_name: String) -> String:
	return "New Spirémon joined: " + spiremon_name

func add_move(move: Move):
	if player_moves.size() < 4:
		player_moves.append(move)
	else:
		pending_move = move
		get_tree().change_scene_to_file("res://scenes/reward/replace_move_scene.tscn")
