extends Area2D

@export var crowInstructions : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	crowInstructions.hide()

func _on_body_entered(body):
	if body.is_in_group("Player") and not Global.crowInstructionShown:
		crowInstructions.show()
		Global.crowInstructionShown = true
	
func _on_body_exited(body):
	crowInstructions.hide()
