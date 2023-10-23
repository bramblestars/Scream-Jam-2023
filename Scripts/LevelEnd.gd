extends Area2D

@export var optionCanvas : CanvasLayer


func _on_body_entered(body):
	if body.is_in_group("Player"):
		optionCanvas.dialogueMenu.show()
		optionCanvas.dialogueMode(true)
		body.nextLevel = true
