extends Control

@onready var background = $Background

@onready var new_move_name_label = $MarginContainer/VBoxContainer/NewMovePanel/VBoxContainer/NewMoveName
@onready var new_move_stats_label = $MarginContainer/VBoxContainer/NewMovePanel/VBoxContainer/NewMoveStats
@onready var new_move_status_label = $MarginContainer/VBoxContainer/NewMovePanel/VBoxContainer/NewMoveStatus

@onready var move_buttons = [
	$MarginContainer/VBoxContainer/VBoxContainer/Move1,
	$MarginContainer/VBoxContainer/VBoxContainer/Move2,
	$MarginContainer/VBoxContainer/VBoxContainer/Move3,
	$MarginContainer/VBoxContainer/VBoxContainer/Move4
]

var new_move: Move

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.texture = load("res://assets/backgrounds/bg1.png")
	new_move = RunManager.pending_move
	setup_new_move_display()
	setup_current_move_buttons()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_replace_selected(index: int) -> void:
	if new_move == null:
		return
	
	var old_move_name = RunManager.player_moves[index].name
	var new_move_name = new_move.name
	
	RunManager.player_moves[index] = new_move
	RunManager.pending_move = null
	
	RunManager.set_map_message(
		RunManager.build_replaced_move_message(old_move_name, new_move_name)
	)
	
	get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")

func setup_new_move_display() -> void:
	if new_move == null:
		new_move_name_label.text = "No Move"
		new_move_stats_label.text = ""
		new_move_status_label.text = ""
		return
	
	new_move_name_label.text = new_move.name
	new_move_stats_label.text = "DMG " + str(new_move.damage) + " | COST " + str(new_move.cost)
	
	if new_move.status != null:
		new_move_status_label.text = new_move.status.name + " " + str(int(new_move.status_chance * 100)) + "%"
	else:
		new_move_status_label.text = "No Status"

func setup_current_move_buttons() -> void:
	var current_moves = RunManager.player_moves
	
	for i in range(move_buttons.size()):
		if i < current_moves.size():
			var move = current_moves[i]
			var button_text = move.name + " | DMG " + str(move.damage) + " | COST " + str(move.cost)
			
			if move.status != null:
				button_text += " | " + move.status.name + " " + str(int(move.status_chance * 100)) + "%"
			
			move_buttons[i].visible = true
			move_buttons[i].text = button_text
			move_buttons[i].pressed.connect(_on_replace_selected.bind(i))
		else:
			move_buttons[i].visible = false
