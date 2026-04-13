extends Control

@onready var background = $Background
@onready var next_button = $MarginContainer/CenterContainer/VBoxContainer/Next

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.texture = load("res://assets/backgrounds/bg1.png")
	AudioManager.play_music("res://assets/audio/music/menu.ogg")
	next_button.pressed.connect(_on_next_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_next_pressed() -> void:
	AudioManager.play_button_sfx("res://assets/audio/sfx/button.ogg")
	get_tree().change_scene_to_file("res://scenes/battle/battle_scene.tscn")
