extends Control

enum NodeType {
	BATTLE,
	HEAL,
	UPGRADE
}

@onready var background = $Background
@onready var status_message = $MarginContainer/VBoxContainer/StatusMessage

@onready var node_cards = [
	$MarginContainer/VBoxContainer/PathArea/HBoxContainer/BattleNode,
	$MarginContainer/VBoxContainer/PathArea/HBoxContainer/HealNode,
	$MarginContainer/VBoxContainer/PathArea/HBoxContainer/UpgradeNode
]

var current_nodes: Array[int] = []

func _ready() -> void:
	if RunManager.selected_spiremon_name == "":
		get_tree().change_scene_to_file("res://scenes/starter/starter_select_scene.tscn")
		return
	
	background.texture = load("res://assets/backgrounds/bg1.png")
	generate_nodes()
	setup_node_cards()
	refresh_map_message()

func generate_nodes() -> void:
	current_nodes.clear()
	
	if RunManager.run_depth == 0:
		current_nodes.append(NodeType.BATTLE)
		return
	
	current_nodes.append(NodeType.BATTLE)
	
	if randf() < 0.5:
		current_nodes.append(NodeType.HEAL)
	
	if randf() < 0.5:
		current_nodes.append(NodeType.UPGRADE)

func setup_node_cards() -> void:
	var card_map = {
		NodeType.BATTLE: $MarginContainer/VBoxContainer/PathArea/HBoxContainer/BattleNode,
		NodeType.HEAL: $MarginContainer/VBoxContainer/PathArea/HBoxContainer/HealNode,
		NodeType.UPGRADE: $MarginContainer/VBoxContainer/PathArea/HBoxContainer/UpgradeNode
	}
	
	# hide all first
	for card in node_cards:
		card.visible = false
	
	# show only generated nodes
	for node_type in current_nodes:
		var card = card_map[node_type]
		card.visible = true
		setup_single_card(card, node_type)

func setup_single_card(card: Button, node_type: int) -> void:
	var title_label = card.get_node("VBoxContainer/Title")
	var description_label = card.get_node("VBoxContainer/Description")
	
	match node_type:
		NodeType.BATTLE:
			title_label.text = "Battle"
			description_label.text = "Fight a wild Spirémon and\nearn a move reward."
		NodeType.HEAL:
			title_label.text = "Heal"
			description_label.text = "Restore your Spirémon to\nfull HP."
		NodeType.UPGRADE:
			title_label.text = "Upgrade"
			description_label.text = "Improve a move or increase\nyour max HP."
	
	if card.pressed.is_connected(_on_node_button_pressed):
		card.pressed.disconnect(_on_node_button_pressed)
	
	card.pressed.connect(_on_node_button_pressed.bind(node_type))

func _on_node_button_pressed(node_type: int) -> void:
	on_node_selected(node_type)

func on_node_selected(node_type: int) -> void:
	RunManager.run_depth += 1
	
	match node_type:
		NodeType.BATTLE:
			get_tree().change_scene_to_file("res://scenes/battle/battle_scene.tscn")
		
		NodeType.HEAL:
			RunManager.player_hp = RunManager.max_player_hp
			RunManager.set_map_message(
				RunManager.build_heal_message(RunManager.player_hp, RunManager.max_player_hp)
			)
			generate_nodes()
			setup_node_cards()
			refresh_map_message()
		
		NodeType.UPGRADE:
			get_tree().change_scene_to_file("res://scenes/upgrade/upgrade_scene.tscn")

func refresh_map_message() -> void:
	status_message.text = RunManager.consume_map_message()
