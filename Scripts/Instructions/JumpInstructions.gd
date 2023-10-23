extends Area2D

@export var jumpInstructions : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	jumpInstructions.hide()

func _on_body_entered(body):
	if body.is_in_group("Player") and not Global.jumpInstructionShown:
		jumpInstructions.show()
		Global.jumpInstructionShown = true
	
func _on_body_exited(body):
	jumpInstructions.hide()
