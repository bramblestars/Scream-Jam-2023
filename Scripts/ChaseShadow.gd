extends Area2D


var moveSpeed : float = 100.0
var paused : bool = false
@onready var sprite : Sprite2D = $Sprite
@onready var ap : AnimationPlayer = $AnimationPlayer
@onready var player : CharacterBody2D = get_parent().get_node("Player")

func _ready():
	ap.play("jump")
	
func _physics_process(delta):
	if(!paused):
		if player.position.x > global_position.x:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		global_position = global_position.move_toward(player.position, moveSpeed * delta)

func setPause(isPaused):
	ap.stop(isPaused)
	paused = isPaused

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.jumpScare()
