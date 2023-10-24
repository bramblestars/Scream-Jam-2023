extends CharacterBody2D

@onready var sprite : Sprite2D = $Sprite2D
@export_file("*.png") var catSit
@export_file("*.png") var catRun
@onready var ap : AnimationPlayer = $AnimationPlayer

var gravity : float = 500
var moveSpeed : float = -200
var paused : bool = false

@export var darkLevel : bool = false

func _ready():
	catSit = load("res://Sprites/Character/cat_sitting.png")
	catRun = load("res://Sprites/Character/cat_running.png")
	
func _physics_process(delta):
	if not paused and not darkLevel:
		if not is_on_floor():
			velocity.y += gravity * delta
		velocity.x = 0
		velocity.x += moveSpeed
		if velocity.x > 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false 
		move_and_slide()
		updateAnimation()
		
func updateAnimation():
		if velocity.x == 0:
			sprite.texture = catSit
			ap.play("sitting")
		else:
			sprite.texture = catRun
			ap.play("run")
			
func setPause(isPaused):
	ap.stop(isPaused)
	paused = isPaused
