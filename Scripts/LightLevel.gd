extends Node2D

@onready var music_player = get_node("/root/Music")

# Called when the node enters the scene tree for the first time.
func _ready():
	music_player.play(Global.music_progress)
