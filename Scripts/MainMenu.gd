extends CanvasLayer

@export_file("*.tscn") var startScene
@export var creditsText : MarginContainer
@export var menuButtons : MarginContainer

func _on_play_pressed():
	get_tree().change_scene_to_file(startScene)

func _on_quit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	creditsText.show()
	menuButtons.hide()

func _on_close_credits_pressed():
	creditsText.hide()
	menuButtons.show()
