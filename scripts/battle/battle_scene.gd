extends Control

@onready var player_hp_label = $VBoxContainer/HBoxContainer/VBoxContainer/PlayerHP
@onready var enemy_hp_label = $VBoxContainer/HBoxContainer/VBoxContainer2/EnemyHP

@onready var move_buttons = [
	$VBoxContainer/GridContainer/Move1,
	$VBoxContainer/GridContainer/Move2,
	$VBoxContainer/GridContainer/Move3,
	$VBoxContainer/GridContainer/Move4
]

@onready var end_turn_button = $VBoxContainer/EndTurn

@onready var battle_log = $VBoxContainer/BattleLog

@onready var energy_label = $VBoxContainer/Energy

var player_hp = 30
var enemy_hp = 20

var player_turn = true

var player_moves: Array[Move] = []

var max_energy = 3
var current_energy = 3

var player_statuses: Array = []
var enemy_statuses: Array = []

func scale_enemy():
	var depth = RunManager.run_depth
	enemy_hp = 20 + (depth * 5)

func add_log(text: String):
	battle_log.text += text + "\n"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
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
	
	var move = player_moves[move_index]
	
	if move.cost > current_energy:
		add_log("Not enough energy!")
		return
	
	current_energy -= move.cost
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
			enemy_statuses.append(new_status)
			add_log("Enemy is burned!")
	
	
	if check_battle_end():
		return
	
	update_ui()
	
	if not is_inside_tree():
		return

func enemy_turn():
	apply_status_effects(player_statuses, true)
	
	var damage = 4
	player_hp -= damage
	
	battle_log.text = "Enemy dealt " + str(damage) + " damage!"
	
	if check_battle_end():
		return
	
	player_turn = true
	add_log("")
	current_energy = max_energy
	set_buttons_enabled(true)
	update_ui()
	end_turn_button.disabled = false

func check_battle_end() -> bool:
	if enemy_hp <= 0:
		print("Player Wins")
		get_tree().change_scene_to_file("res://scenes/reward/reward_scene.tscn")
		return true
	elif player_hp <= 0:
		print("Player Loses")
		get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
		return true
	
	return false

func update_ui():
	player_hp_label.text = "HP: " + str(player_hp)
	enemy_hp_label.text = "HP: " + str(enemy_hp)
	energy_label.text = "Energy: " + str(current_energy) + "/" + str(max_energy)
	
	for i in range(move_buttons.size()):
		if i < player_moves.size():
			var move = player_moves[i]
			move_buttons[i].disabled = (
				move.cost > current_energy or not player_turn
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

func apply_status_effects(status_list, is_player: bool):
	for status in status_list:
		if status.name == "Burn":
			if is_player:
				player_hp -= status.damage_per_turn
				add_log("You took " + str(status.damage_per_turn) + " burn damage!")
			else:
				enemy_hp -= status.damage_per_turn
				add_log("Enemy took " + str(status.damage_per_turn) + " burn damage!")
			
			status.duration -= 1
	
	for i in range(status_list.size() - 1, -1, -1):
		if status_list[i].duration <= 0:
			status_list.remove_at(i)
