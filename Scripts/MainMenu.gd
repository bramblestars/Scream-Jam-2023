extends CanvasLayer

@onready var startScenePath = "res://Scenes/Levels/level_1_light.tscn"
@export var creditsText : MarginContainer
@export var menuButtons : MarginContainer
@export var titleArt : TextureRect
@export var title : Sprite2D

func _on_play_pressed():
	get_tree().change_scene_to_file(startScenePath)

func _on_quit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	creditsText.show()
	menuButtons.hide()
	title.hide()
	titleArt.hide()

func _on_close_credits_pressed():
	creditsText.hide()
	menuButtons.show()
	title.show()
	titleArt.show()
