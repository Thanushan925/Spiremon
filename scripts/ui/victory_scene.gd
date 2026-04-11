extends Control

@onready var background = $Background
@onready var restart_button = $MarginContainer/CenterContainer/VBoxContainer/Restart
@onready var main_menu_button = $MarginContainer/CenterContainer/VBoxContainer/MainMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.texture = load("res://assets/backgrounds/bg1.png")
	restart_button.pressed.connect(_on_restart_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_restart_pressed() -> void:
	RunManager.reset_run()
	get_tree().change_scene_to_file("res://scenes/starter/starter_select_scene.tscn")

func _on_main_menu_pressed() -> void:
	RunManager.reset_run()
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
