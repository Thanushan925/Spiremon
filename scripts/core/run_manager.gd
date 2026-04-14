extends Node

var run_depth = 0
var player_moves: Array[Move] = []
var pending_move: Move = null
var max_player_hp = 30
var player_hp = 30
var map_message = ""
var selected_spiremon_name = ""
var selected_starter_move_path = ""
var max_run_depth = 10
var used_enemy_names: Array[String] = []
var pending_boss_fight = false
var final_map_heal_used = false

var unlocked_starters = {
	"Charizard": true,
	"Blastoise": false,
	"Venusaur": false
}

func reset_run():
	run_depth = 0
	max_player_hp = 30
	player_hp = max_player_hp
	player_moves.clear()
	pending_move = null
	map_message = ""
	selected_spiremon_name = ""
	selected_starter_move_path = ""
	used_enemy_names.clear()
	pending_boss_fight = false
	final_map_heal_used = false

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

func build_max_hp_upgrade_message(amount: int, new_max_hp: int) -> String:
	return "Max HP increased by " + str(amount) + "! New max HP: " + str(new_max_hp)

func build_move_upgrade_message(move_name: String, upgrade_text: String) -> String:
	return move_name + " was upgraded: " + upgrade_text
	
func is_final_map_node() -> bool:
	return run_depth == max_run_depth - 1

func get_progress_text() -> String:
	return str(run_depth + 1) + "/" + str(max_run_depth)

func set_starter_choice(spiremon_name: String, move_path: String):
	selected_spiremon_name = spiremon_name
	selected_starter_move_path = move_path
	player_moves.clear()
	player_moves.append(load(move_path))
	player_moves.append(load("res://resources/moves/defend.tres"))

func add_move(move: Move):
	if player_moves.size() < 4:
		player_moves.append(move)
	else:
		pending_move = move
		get_tree().change_scene_to_file("res://scenes/reward/replace_move_scene.tscn")

func is_charizard() -> bool:
	return selected_spiremon_name == "Charizard"

func is_blastoise() -> bool:
	return selected_spiremon_name == "Blastoise"

func is_venusaur() -> bool:
	return selected_spiremon_name == "Venusaur"
