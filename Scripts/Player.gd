extends CharacterBody2D

var move_speed : float = 100.0
var jump_force : float = 200.0
var gravity : float = 500.0
@onready var sprite : Sprite2D = $Sprite
@onready var ap : AnimationPlayer = $AnimationPlayer

var inventory = {}

var score : int = 0
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	velocity.x = 0
	if Input.is_action_pressed("moveLeft"):
		velocity.x -= move_speed
		sprite.flip_h = false
	if Input.is_action_pressed("moveRight"):
		velocity.x += move_speed
		sprite.flip_h = true
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
		
	move_and_slide()
	updateAnimation()
	
func updateAnimation():
	if is_on_floor():
		if velocity.x == 0:
			ap.play("move")
		else:
			ap.play("idle")
	else:
		ap.play("jump")
	

func gameOver():
	get_tree().reload_current_scene()
	
func addObject(item):
	if item not in inventory:
		inventory[item] = 0
	inventory[item] = inventory[item] + 1
	
	
