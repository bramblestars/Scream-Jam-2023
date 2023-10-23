extends Node2D

@onready var music_player = get_node("/root/Music")
@export var optionCanvas : CanvasLayer
@export var nextLevelFilePath : String

# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play(Global.dark_music_progress)
	music_player.play(Global.music_progress)
	optionCanvas.dialogueMenu.hide()
