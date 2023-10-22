extends Area2D

@export var moveInstructions : Sprite2D

func _ready():
	moveInstructions.show()

func _on_body_exited(body):
	if body.is_in_group("Player"):
		moveInstructions.hide()
