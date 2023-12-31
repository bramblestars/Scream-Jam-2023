extends CanvasLayer
@onready var optionMenu : CenterContainer = $OptionMenu
@onready var backPanel : Panel = $BackPanel
@onready var dialogueMenu : Control = $DialogueMenu
@onready var volumeSlider = $OptionMenu/VBoxContainer/Audio
@onready var movingObject = get_tree().get_nodes_in_group("Pause")
@onready var textLabel = get_node("DialogueMenu/Panel/Label")

@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@export var player : CharacterBody2D
@export_file("*.tscn") var mainMenu

var hidden : bool = false
var dialogue : bool = false
var dialogueIndex : int = 0
@export var textValues : Array = ["Hi", "Bye", "See"]
@export var dialogueStopValues : Array = [2]
# Called when the node enters the scene tree for the first time.
func _ready():
	optionMenu.hide()
	backPanel.hide()
	#dialogueMenu.hide()
	volumeSlider.value = Global.volume
	hidden = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("escape"):
		if hidden:
			setPauseValue(true)
			backPanel.show()
			optionMenu.show()
		else:
			setPauseValue(false)
			backPanel.hide()
			optionMenu.hide()
		hidden = !hidden
	if hidden:
		if !dialogue:
			if Input.is_action_just_released("test"):
				dialogueMode(true)
		if dialogue:
			if Input.is_action_just_released("interact"):
				dialogueIndex += 1
				print(dialogueIndex)
				if dialogueIndex in dialogueStopValues:
					dialogueMode(false)
			if dialogueIndex < textValues.size():
				textLabel.text = textValues[dialogueIndex]
			else:
				player.jumpScare()
				

func setPauseValue(pause):
	for chr in movingObject: 
		chr.setPause(pause)
		
func dialogueMode(dialogueOn):
	dialogue = dialogueOn
	if(dialogueOn):
		dialogueMenu.show()	
	else:
		dialogueMenu.hide()


func _on_continue_pressed():
	for chr in movingObject:
		chr.setPause(false)
	optionMenu.hide()
	backPanel.hide()
	hidden = true

func _on_main_menu_pressed():
	get_tree().change_scene_to_file(mainMenu)

func _on_quit_pressed():
	get_tree().quit()

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_audio_drag_ended(value_changed):
	pass # Replace with function body.

func _on_button_pressed():
	if hidden: 
		hidden = false
		setPauseValue(true)
		optionMenu.show()
		backPanel.show()
		
		
func _on_audio_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < 0.05)
	Global.volume = value



