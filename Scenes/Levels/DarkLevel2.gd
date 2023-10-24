extends Node2D

@onready var music_player = get_node("/root/Music")
@export var optionCanvas : CanvasLayer
@export var nextLevelFilePath : String

# Called when the node enters the scene tree for the first time.
func _ready():
	music_player.play(Global.music_progress)
	optionCanvas.dialogueMode(true)
	$Player.shadowLevel = false
