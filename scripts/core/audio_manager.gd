# Core file for audio management

extends Node

var current_music_path: String = ""

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer
var button_sfx_player: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)

	button_sfx_player = AudioStreamPlayer.new()
	add_child(button_sfx_player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func play_music(path: String) -> void:
	if current_music_path == path:
		return
	
	current_music_path = path
	var stream = load(path)
	if stream != null:
		music_player.stream = stream
		music_player.volume_db = -8
		music_player.play()

func stop_music() -> void:
	music_player.stop()
	current_music_path = ""

func play_sfx(path: String, volume_db: float = -4) -> void:
	var stream = load(path)
	if stream != null:
		sfx_player.stream = stream
		sfx_player.volume_db = volume_db
		sfx_player.play()

func play_button_sfx(path: String, volume_db: float = -8) -> void:
	var stream = load(path)
	if stream != null:
		button_sfx_player.stream = stream
		button_sfx_player.volume_db = volume_db
		button_sfx_player.play()
