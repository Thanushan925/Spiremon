extends Control

@onready var move_buttons = [
	$CenterContainer/VBoxContainer/Move1,
	$CenterContainer/VBoxContainer/Move2,
	$CenterContainer/VBoxContainer/Move3,
	$CenterContainer/VBoxContainer/Move4
]

@onready var back_button = $CenterContainer/VBoxContainer/Back

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_move_buttons()
	back_button.pressed.connect(_on_back_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func setup_move_buttons():
	for i in range(move_buttons.size()):
		if i < RunManager.player_moves.size():
			var move = RunManager.player_moves[i]
			move_buttons[i].visible = true
			move_buttons[i].text = move.name + " | DMG: " + str(move.damage) + " | COST: " + str(move.cost)
			if move.status != null:
				move_buttons[i].text += " | STATUS: " + str(int(move.status_chance * 100)) + "%"
			if move_buttons[i].pressed.is_connected(_on_move_button_pressed):
				move_buttons[i].pressed.disconnect(_on_move_button_pressed)
			move_buttons[i].pressed.connect(_on_move_button_pressed.bind(i))
		else:
			move_buttons[i].visible = false

func _on_move_button_pressed(index: int):
	var move = RunManager.player_moves[index]
	apply_random_upgrade(move)
	get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")

func apply_random_upgrade(move: Move):
	var possible_upgrades = ["damage", "cost"]
	
	if move.status != null:
		possible_upgrades.append("status_chance")
	
	var chosen_upgrade = possible_upgrades.pick_random()
	
	match chosen_upgrade:
		"damage":
			move.damage += 3
			RunManager.set_map_message(
				RunManager.build_move_upgrade_message(move.name, "+3 damage")
			)
		"cost":
			if move.cost > 1:
				move.cost -= 1
				RunManager.set_map_message(
					RunManager.build_move_upgrade_message(move.name, "-1 energy cost")
				)
			else:
				move.damage += 3
				RunManager.set_map_message(
					RunManager.build_move_upgrade_message(move.name, "+3 damage")
				)
		"status_chance":
			move.status_chance = min(move.status_chance + 0.2, 1.0)
			RunManager.set_map_message(
				RunManager.build_move_upgrade_message(move.name, "+20% status chance")
			)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/upgrade/upgrade_scene.tscn")
