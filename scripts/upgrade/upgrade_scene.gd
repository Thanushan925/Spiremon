extends Control

@onready var upgrade_move_button = $CenterContainer/VBoxContainer/UpgradeMove
@onready var increase_hp_button = $CenterContainer/VBoxContainer/IncreaseHP

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
