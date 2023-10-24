extends Area2D

@export var optionCanvas : CanvasLayer
@export var level : Node2D

func _on_body_entered(body):
	if body.is_in_group("Shadow"):
		print("hihihi")
		get_tree().change_scene_to_file(level.nextLevelFilePath)
