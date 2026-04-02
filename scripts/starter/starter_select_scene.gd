extends Control

@onready var charizard_button = $CenterContainer/VBoxContainer/Starter1
@onready var blastoise_button = $CenterContainer/VBoxContainer/Starter2
@onready var venusaur_button = $CenterContainer/VBoxContainer/Starter3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	charizard_button.pressed.connect(_on_charizard_pressed)
	blastoise_button.pressed.connect(_on_blastoise_pressed)
	venusaur_button.pressed.connect(_on_venusaur_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_charizard_pressed():
	RunManager.set_starter_choice("Charizard", "res://resources/moves/fire_punch.tres")
	get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")

func _on_blastoise_pressed():
	RunManager.set_starter_choice("Blastoise", "res://resources/moves/water_gun.tres")
	get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")

func _on_venusaur_pressed():
	RunManager.set_starter_choice("Venusaur", "res://resources/moves/razor_leaf.tres")
	get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")
