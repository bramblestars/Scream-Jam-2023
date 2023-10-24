extends Area2D

@export var optionCanvas : CanvasLayer


func _on_body_entered(body):
	if body.is_in_group('Player'):
		print("end level")
		body.nextLevel = true
		print(optionCanvas.dialogue)
		optionCanvas.dialogueMode(true)
