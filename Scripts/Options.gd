extends CanvasLayer
@onready var optionMenu : CenterContainer = $OptionMenu
@onready var movingObject = get_tree().get_nodes_in_group("Pause")
@export_file("*.tscn") var mainMenu

var hidden : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	optionMenu.hide()
	hidden = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("escape"):
		if hidden:
			for chr in movingObject: 
				chr.setPause(true)
			optionMenu.show()
		else:
			for chr in movingObject:
				chr.setPause(false)
			optionMenu.hide()
		hidden = !hidden

func _on_continue_pressed():
	for chr in movingObject:
		chr.setPause(false)
	optionMenu.hide()
	hidden = true

func _on_quit_pressed():
	get_tree().change_scene_to_file(mainMenu)

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_audio_drag_ended(value_changed):
	pass # Replace with function body.
