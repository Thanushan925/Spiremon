extends Control

enum NodeType {
	BATTLE,
	HEAL,
	UPGRADE
}

@onready var buttons = [
	$CenterContainer/VBoxContainer/HBoxContainer/Option1,
	$CenterContainer/VBoxContainer/HBoxContainer/Option2,
	$CenterContainer/VBoxContainer/HBoxContainer/Option3
]

var current_nodes = []
var run_depth = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_nodes()
	setup_buttons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	

func generate_nodes():
	current_nodes.clear()
	
	var num_nodes = randi_range(2, 3)
	
	for i in range(num_nodes):
		var type = NodeType.values().pick_random()
		current_nodes.append(type)

func setup_buttons():
	for i in range(buttons.size()):
		if buttons[i].pressed.is_connected(_on_map_button_pressed):
			buttons[i].pressed.disconnect(_on_map_button_pressed)
		
		if i < current_nodes.size():
			var node_type = current_nodes[i]
			buttons[i].visible = true
			buttons[i].text = get_node_name(node_type)
			buttons[i].set_meta("node_type", node_type)
			buttons[i].pressed.connect(_on_map_button_pressed.bind(buttons[i]))
		else:
			buttons[i].visible = false

func _on_map_button_pressed(button):
	var node_type = button.get_meta("node_type")
	on_node_selected(node_type)

func get_node_name(node_type):
	match node_type:
		NodeType.BATTLE:
			return "⚔ Battle"
		NodeType.HEAL:
			return "❤ Heal"
		NodeType.UPGRADE:
			return "⬆ Upgrade"
	return "Unknown"

func on_node_selected(node_type):
	RunManager.run_depth += 1
	
	match node_type:
		NodeType.BATTLE:
			get_tree().change_scene_to_file("res://scenes/battle/battle_scene.tscn")
		NodeType.HEAL:
			RunManager.player_hp = RunManager.max_player_hp
			print("Healed to full HP")
			generate_nodes()
			setup_buttons()
		NodeType.UPGRADE:
			print("Upgrade selected")
