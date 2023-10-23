extends Node2D

@onready var music_player = get_node("/root/Music")
@export var optionCanvas : CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	music_player.play(Global.music_progress)
	optionCanvas.dialogueMode(true)
