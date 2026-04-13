extends Control

@onready var background = $Background
@onready var restart_button = $MarginContainer/CenterContainer/VBoxContainer/Restart
@onready var main_menu_button = $MarginContainer/CenterContainer/VBoxContainer/MainMenu

# Called when the node enters the scene tree for the first time.
func _pressed() -> void:
	AudioManager.play_button_sfx("res://assets/audio/sfx/button.ogg")
	RunManager.reset_run()
	get_tree().change_scene_to_file("res://scenes/starter/starter_select_scene.tscn")

func _on_main_menu_pressed() -> void:
	AudioManager.play_button_sfx("res://assets/audio/sfx/button.ogg")
	RunManager.reset_run()
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
