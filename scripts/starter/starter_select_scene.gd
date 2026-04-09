extends Control

@onready var background = $Background

@onready var charizard_sprite = $MarginContainer/VBoxContainer/HBoxContainer/StarterCard1/VBoxContainer/Sprite
@onready var blastoise_sprite = $MarginContainer/VBoxContainer/HBoxContainer/StarterCard2/VBoxContainer/Sprite
@onready var venusaur_sprite = $MarginContainer/VBoxContainer/HBoxContainer/StarterCard3/VBoxContainer/Sprite

@onready var charizard_name = $MarginContainer/VBoxContainer/HBoxContainer/StarterCard1/VBoxContainer/Name
@onready var blastoise_name = $MarginContainer/VBoxContainer/HBoxContainer/StarterCard2/VBoxContainer/Name
@onready var venusaur_name = $MarginContainer/VBoxContainer/HBoxContainer/StarterCard3/VBoxContainer/Name

@onready var charizard_move = $MarginContainer/VBoxContainer/HBoxContainer/StarterCard1/VBoxContainer/MovePreview
@onready var blastoise_move = $MarginContainer/VBoxContainer/HBoxContainer/StarterCard2/VBoxContainer/MovePreview
@onready var venusaur_move = $MarginContainer/VBoxContainer/HBoxContainer/StarterCard3/VBoxContainer/MovePreview

@onready var charizard_button = $MarginContainer/VBoxContainer/HBoxContainer/StarterCard1/VBoxContainer/Select
@onready var blastoise_button = $MarginContainer/VBoxContainer/HBoxContainer/StarterCard2/VBoxContainer/Select
@onready var venusaur_button = $MarginContainer/VBoxContainer/HBoxContainer/StarterCard3/VBoxContainer/Select

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_visuals()
	setup_text()
	charizard_button.pressed.connect(_on_charizard_pressed)
	blastoise_button.pressed.connect(_on_blastoise_pressed)
	venusaur_button.pressed.connect(_on_venusaur_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func setup_text():
	charizard_name.text = "Charizard"
	blastoise_name.text = "Blastoise"
	venusaur_name.text = "Venusaur"

	charizard_move.text = "Starts with Fire Punch"
	blastoise_move.text = "Starts with Water Gun"
	venusaur_move.text = "Starts with Razor Leaf"
	
func load_visuals():
	background.texture = load("res://assets/backgrounds/bgStarter.png")
	charizard_sprite.texture = load("res://assets/sprites/starters/charizard.png")
	blastoise_sprite.texture = load("res://assets/sprites/starters/blastoise.png")
	venusaur_sprite.texture = load("res://assets/sprites/starters/venusaur.png")

func _on_charizard_pressed():
	RunManager.set_starter_choice("Charizard", "res://resources/moves/fire_punch.tres")
	get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")

func _on_blastoise_pressed():
	RunManager.set_starter_choice("Blastoise", "res://resources/moves/water_gun.tres")
	get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")

func _on_venusaur_pressed():
	RunManager.set_starter_choice("Venusaur", "res://resources/moves/razor_leaf.tres")
	get_tree().change_scene_to_file("res://scenes/map/map_scene.tscn")
