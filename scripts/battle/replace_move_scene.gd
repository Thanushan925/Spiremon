extends Node

@onready var move_buttons = [
	$VBoxContainer/HBoxContainer/Move1,
	$VBoxContainer/HBoxContainer/Move2,
	$VBoxContainer/HBoxContainer/Move3,
	$VBoxContainer/HBoxContainer/Move4
]

@onready var new_move_label = $VBoxContainer/NewMove

var new_move: Move

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_move = RunManager.pending_move
	setup_ui()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func setup_ui():
	var current_moves = RunManager.player_moves
	
	for i in range(move_buttons.size()):
		var move = current_moves[i]
		move_buttons[i].text = move.name
		move_buttons[i].pressed.connect(_on_replace_selected.bind(i))
	
	new_move_label.text = "New Move: " + new_move.name

func _on_replace_selected(index):
	RunManager.player_moves[index] = new_move
	RunManager.pending_move = null
	
	get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")
