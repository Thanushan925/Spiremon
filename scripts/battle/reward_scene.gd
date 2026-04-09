extends Control

@onready var background = $Background

@onready var move_cards = [
	$MarginContainer/VBoxContainer/HBoxContainer/MoveCard1,
	$MarginContainer/VBoxContainer/HBoxContainer/MoveCard2,
	$MarginContainer/VBoxContainer/HBoxContainer/MoveCard3
]

@onready var skip_button = $MarginContainer/VBoxContainer/Skip

var reward_moves: Array[Move] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.texture = load("res://assets/backgrounds/bg1.png")
	generate_rewards()
	setup_cards()
	skip_button.pressed.connect(_on_skip_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func generate_rewards():
	var all_moves = [
		load("res://resources/moves/fire_punch.tres"),
		load("res://resources/moves/water_gun.tres"),
		load("res://resources/moves/razor_leaf.tres")
	]
	
	reward_moves.clear()
	
	while reward_moves.size() < 3:
		var move = all_moves.pick_random()
		if move not in reward_moves:
			reward_moves.append(move)

func setup_cards():
	for i in range(move_cards.size()):
		var card = move_cards[i]
		var move = reward_moves[i]
		
		var move_name_label = card.get_node("VBoxContainer/Name")
		var move_stats_label = card.get_node("VBoxContainer/Stats")
		var move_status_label = card.get_node("VBoxContainer/Status")
		var select_button = card.get_node("VBoxContainer/Select")
		
		move_name_label.text = move.name
		move_stats_label.text = "DMG " + str(move.damage) + " | COST " + str(move.cost)
		
		if move.status != null:
			move_status_label.text = move.status.name + " " + str(int(move.status_chance * 100)) + "%"
		else:
			move_status_label.text = "No Status"
		
		select_button.pressed.connect(_on_move_selected.bind(move))

func _on_move_selected(move: Move):
	RunManager.add_move(move)
	
	if RunManager.pending_move == null:
		RunManager.set_map_message(
			RunManager.build_learned_move_message(move.name)
		)
		get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")

func _on_skip_pressed():
	RunManager.set_map_message(
		RunManager.build_skipped_reward_message()
	)
	get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")
