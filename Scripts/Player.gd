extends CharacterBody2D

var moveSpeed : float = 100.0
var jumpForce : float = 300.0
var gravity : float = 600.0
var paused : bool = false
@onready var sprite : Sprite2D = $Sprite
@onready var ap : AnimationPlayer = $AnimationPlayer
@export var shadowLevel : bool = false

var inventory = {}

var score : int = 0
	
func _physics_process(delta):
	if not paused:
		if shadowLevel and global_position.y > 300:
			gameOver()
		if not is_on_floor():
			velocity.y += gravity * delta
			
		velocity.x = 0
		if Input.is_action_pressed("moveLeft"):
			velocity.x -= moveSpeed
			sprite.flip_h = false
		if Input.is_action_pressed("moveRight"):
			velocity.x += moveSpeed
			sprite.flip_h = true
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = -jumpForce
			
		move_and_slide()
		updateAnimation()
	
func updateAnimation():
	if is_on_floor():
		if velocity.x == 0:
			ap.play("idle")
		else:
			ap.play("move")
	else:
		ap.play("jump")
	

func gameOver():
	get_tree().reload_current_scene()
	
func addObject(item):
	if item not in inventory:
		inventory[item] = 0
	inventory[item] = inventory[item] + 1
	
func setPause(isPaused):
	paused = isPaused
	
	
