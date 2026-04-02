extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/VBoxContainer/Start.pressed.connect(_on_start_pressed)
	$CenterContainer/VBoxContainer/Quit.pressed.connect(_on_quit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_start_pressed():
	RunManager.reset_run()
	get_tree().change_scene_to_file("res://scenes/starter/starter_select_scene.tscn")

func _on_quit_pressed():
	get_tree().quit()
