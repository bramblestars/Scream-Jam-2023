extends CanvasLayer
@onready var optionMenu : TextureRect = $OptionMenu
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
			optionMenu.show()
		else:
			optionMenu.hide()
		hidden = !hidden

func _on_continue_pressed():
	optionMenu.hide()
	hidden = true

func _on_quit_pressed():
	get_tree().change_scene_to_file(mainMenu)
