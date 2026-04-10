extends Control

@onready var background = $Background

@onready var move_buttons = [
	$MarginContainer/VBoxContainer/MoveListPanel/VBoxContainer/Move1,
	$MarginContainer/VBoxContainer/MoveListPanel/VBoxContainer/Move2,
	$MarginContainer/VBoxContainer/MoveListPanel/VBoxContainer/Move3,
	$MarginContainer/VBoxContainer/MoveListPanel/VBoxContainer/Move4
]

@onready var back_button = $MarginContainer/VBoxContainer/Back

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.texture = load("res://assets/backgrounds/bg1.png")
	setup_move_buttons()
	back_button.pressed.connect(_on_back_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func setup_move_buttons() -> void:
	for i in range(move_buttons.size()):
		if i < RunManager.player_moves.size():
			var move = RunManager.player_moves[i]
			move_buttons[i].visible = true
			
			var button_text = move.name + " | DMG " + str(move.damage) + " | COST " + str(move.cost)
			if move.status != null:
				button_text += " | " + move.status.name + " " + str(int(move.status_chance * 100)) + "%"
			
			move_buttons[i].text = button_text
			
			if move_buttons[i].pressed.is_connected(_on_move_button_pressed):
				move_buttons[i].pressed.disconnect(_on_move_button_pressed)
			
			move_buttons[i].pressed.connect(_on_move_button_pressed.bind(i))
		else:
			move_buttons[i].visible = false

func _on_move_button_pressed(index: int) -> void:
	var move = RunManager.player_moves[index]
	apply_random_upgrade(move)
	get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")

func apply_random_upgrade(move: Move) -> void:
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

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/upgrade/upgrade_scene.tscn")
