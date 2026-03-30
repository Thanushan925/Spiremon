extends Node

@onready var move_buttons = [
	$VBoxContainer/HBoxContainer/MoveOption1,
	$VBoxContainer/HBoxContainer/MoveOption2,
	$VBoxContainer/HBoxContainer/MoveOption3
]

@onready var skip_button = $VBoxContainer/SkipButton

var reward_moves: Array[Move] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_rewards()
	setup_buttons()


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

func setup_buttons():
	for i in range(move_buttons.size()):
		var move = reward_moves[i]
		move_buttons[i].text = move.name
		move_buttons[i].pressed.connect(_on_move_selected.bind(move))
	
	skip_button.pressed.connect(_on_skip_pressed)

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
