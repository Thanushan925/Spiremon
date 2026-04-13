extends Control

@onready var background = $Background
@onready var start_button = $MarginContainer/CenterContainer/PanelContainer/VBoxContainer/Start
@onready var back_button = $MarginContainer/CenterContainer/PanelContainer/VBoxContainer/Back

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.texture = load("res://assets/backgrounds/bg1.png")
	AudioManager.play_music("res://assets/audio/music/menu.ogg")
	start_button.pressed.connect(_on_start_pressed)
	back_button.pressed.connect(_on_back_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	AudioManager.play_button_sfx("res://assets/audio/sfx/button.ogg")
	get_tree().change_scene_to_file("res://scenes/starter/starter_select_scene.tscn")

func _on_back_pressed() -> void:
	AudioManager.play_button_sfx("res://assets/audio/sfx/button.ogg")
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
