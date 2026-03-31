extends Control

@onready var player_hp_label = $VBoxContainer/HBoxContainer/VBoxContainer/PlayerHP
@onready var enemy_hp_label = $VBoxContainer/HBoxContainer/VBoxContainer2/EnemyHP
@onready var player_status_label = $VBoxContainer/HBoxContainer/VBoxContainer/PlayerStatus
@onready var enemy_status_label = $VBoxContainer/HBoxContainer/VBoxContainer2/EnemyStatus

@onready var move_buttons = [
	$VBoxContainer/GridContainer/Move1,
	$VBoxContainer/GridContainer/Move2,
	$VBoxContainer/GridContainer/Move3,
	$VBoxContainer/GridContainer/Move4
]

@onready var end_turn_button = $VBoxContainer/EndTurn

@onready var battle_log = $VBoxContainer/BattleLog

@onready var energy_label = $VBoxContainer/Energy

var player_hp = 0
var enemy_hp = 20

var player_turn = true

var player_moves: Array[Move] = []

var max_energy = 3
var current_energy = 3

var player_statuses: Array = []
var enemy_statuses: Array = []
var used_move_indices_this_turn: Array[int] = []

func scale_enemy():
	var depth = RunManager.run_depth
	enemy_hp = 20 + (depth * 5)

func add_log(text: String):
	battle_log.text += text + "\n"
	
func format_status_message(template: String, target_name: String, status_name: String) -> String:
	return template.replace("{target}", target_name).replace("{status}", status_name)
	
func get_status_text(status_list: Array) -> String:
	if status_list.is_empty():
		return "Status: None"
	
	var parts = []
	for status in status_list:
		parts.append(status.name + " (" + str(status.duration) + ")")
	
	return "Status: " + ", ".join(parts)
	
func apply_status_to_target(status_list: Array, new_status: StatusEffect, target_name: String):
	for status in status_list:
		if status.name == new_status.name:
			status.duration = new_status.duration
			add_log(format_status_message(status.refresh_message, target_name, status.name))
			return
	
	status_list.append(new_status)
	add_log(format_status_message(new_status.apply_message, target_name, new_status.name))

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	player_hp = RunManager.player_hp
	RunManager.player_hp = player_hp
	used_move_indices_this_turn.clear()
	load_moves()
	scale_enemy()
	update_ui()
	setup_moves()
	set_buttons_enabled(true)
	end_turn_button.pressed.connect(_on_end_turn_pressed)
	print("Run Depth: ", RunManager.run_depth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func load_moves():
	if RunManager.player_moves.is_empty():
		RunManager.player_moves.append(load("res://resources/moves/fire_punch.tres"))
	
	player_moves = RunManager.player_moves

func setup_moves():
	for i in range(move_buttons.size()):
		if i < player_moves.size():
			var move = player_moves[i]
			move_buttons[i].text = move.name + " (" + str(move.cost) + ")"
			move_buttons[i].visible = true
			
			if not move_buttons[i].pressed.is_connected(_on_move_pressed):
				move_buttons[i].pressed.connect(_on_move_pressed.bind(i))
		else:
			move_buttons[i].visible = false

func _on_move_pressed(move_index):
	if not player_turn:
		return
	
	if move_index in used_move_indices_this_turn:
		return
	
	var move = player_moves[move_index]
	
	if move.cost > current_energy:
		add_log("Not enough energy!")
		return
	
	current_energy -= move.cost
	used_move_indices_this_turn.append(move_index)
	player_attack(move_index)
	update_ui()

func player_attack(move_index):
	var move = player_moves[move_index]
	var damage = move.damage
	enemy_hp -= damage
	
	battle_log.text = move.name + " dealt " + str(damage) + " damage!\n"

	if move.status != null:
		if randf() <= move.status_chance:
			var new_status = move.status.duplicate()
			apply_status_to_target(enemy_statuses, new_status, "Enemy")
	
	if check_battle_end():
		return
	
	update_ui()
	
	if not is_inside_tree():
		return

func enemy_turn():
	apply_status_effects(player_statuses, true)
	
	var damage = 4
	player_hp -= damage
	RunManager.player_hp = player_hp
	
	battle_log.text = "Enemy dealt " + str(damage) + " damage!"
	
	if check_battle_end():
		return
	
	player_turn = true
	battle_log.text = ""
	current_energy = max_energy
	used_move_indices_this_turn.clear()
	set_buttons_enabled(true)
	update_ui()
	end_turn_button.disabled = false

func check_battle_end() -> bool:
	if enemy_hp <= 0:
		print("Player Wins")
		get_tree().change_scene_to_file("res://scenes/reward/reward_scene.tscn")
		return true
	elif player_hp <= 0:
		RunManager.player_hp = 0
		print("Player Loses")
		get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
		return true
	
	return false

func update_ui():
	player_hp_label.text = "HP: " + str(player_hp)
	enemy_hp_label.text = "HP: " + str(enemy_hp)
	energy_label.text = "Energy: " + str(current_energy) + "/" + str(max_energy)
	player_status_label.text = get_status_text(player_statuses)
	enemy_status_label.text = get_status_text(enemy_statuses)
	
	for i in range(move_buttons.size()):
		if i < player_moves.size():
			var move = player_moves[i]
			move_buttons[i].disabled = (
				move.cost > current_energy
				or not player_turn
				or i in used_move_indices_this_turn
			)

func set_buttons_enabled(enabled: bool):
	for button in move_buttons:
		button.disabled = not enabled

func _on_end_turn_pressed():
	if not player_turn:
		return
	
	player_turn = false
	set_buttons_enabled(false)
	end_turn_button.disabled = true
	
	await get_tree().create_timer(0.5).timeout
	
	if not is_inside_tree():
		return
	
	apply_status_effects(enemy_statuses, false)
	enemy_turn()

func apply_status_effects(status_list: Array, is_player: bool):
	for status in status_list:
		if status.damage_per_turn > 0:
			if is_player:
				player_hp -= status.damage_per_turn
				RunManager.player_hp = player_hp
				add_log("You took " + str(status.damage_per_turn) + " damage from " + status.name + "!")
			else:
				enemy_hp -= status.damage_per_turn
				add_log("Enemy took " + str(status.damage_per_turn) + " damage from " + status.name + "!")
		
		status.duration -= 1
	
	for i in range(status_list.size() - 1, -1, -1):
		if status_list[i].duration <= 0:
			status_list.remove_at(i)
