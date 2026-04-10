extends Control

@onready var background = $Background

@onready var upgrade_move_title = $MarginContainer/VBoxContainer/HBoxContainer/UpgradeMoveCard/VBoxContainer/Title
@onready var upgrade_move_description = $MarginContainer/VBoxContainer/HBoxContainer/UpgradeMoveCard/VBoxContainer/Description
@onready var upgrade_move_button = $MarginContainer/VBoxContainer/HBoxContainer/UpgradeMoveCard/VBoxContainer/Select

@onready var increase_hp_title = $MarginContainer/VBoxContainer/HBoxContainer/IncreaseHPCard/VBoxContainer/Title
@onready var increase_hp_description = $MarginContainer/VBoxContainer/HBoxContainer/IncreaseHPCard/VBoxContainer/Description
@onready var increase_hp_button = $MarginContainer/VBoxContainer/HBoxContainer/IncreaseHPCard/VBoxContainer/Select

# Called when the node enters the scene tree for the first time.
func _ready():
	background.texture = load("res://assets/backgrounds/bg1.png")
	setup_text()
	upgrade_move_button.pressed.connect(_on_upgrade_move_pressed)
	increase_hp_button.pressed.connect(_on_increase_hp_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_upgrade_move_pressed():
	get_tree().change_scene_to_file("res://scenes/upgrade/upgrade_move_scene.tscn")

func _on_increase_hp_pressed():
	RunManager.max_player_hp += 5
	RunManager.player_hp = min(RunManager.player_hp + 5, RunManager.max_player_hp)
	RunManager.set_map_message(
		RunManager.build_max_hp_upgrade_message(5, RunManager.max_player_hp)
	)
	get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")

func setup_text():
	upgrade_move_title.text = "Upgrade a Move"
	upgrade_move_description.text = "Pick one of your moves for a random bonus:\n+3 damage, -1 cost, or +20% status chance."
	
	increase_hp_title.text = "Increase Max HP"
	increase_hp_description.text = "Gain +5 max HP."
