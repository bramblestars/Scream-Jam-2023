extends CanvasLayer

@export_file("*.tscn") var startScene

func _on_play_pressed():
	get_tree().change_scene_to_file(startScene)

func _on_quit_pressed():
	get_tree().quit()
