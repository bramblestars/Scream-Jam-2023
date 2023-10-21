extends CharacterBody2D

var moveSpeed : float = 100.0
var jumpForce : float = 400.0
var gravity : float = 600.0
var grounded : float = true
var paused : bool = false
@onready var sprite : Sprite2D = $Sprite
@onready var ap : AnimationPlayer = $AnimationPlayer
	
func _physics_process(delta):
	if not paused:
		if not grounded:
			velocity.y -= gravity * delta
			
		velocity.x = 0
		if Input.is_action_pressed("moveLeft"):
			velocity.x -= moveSpeed
			sprite.flip_h = true
		if Input.is_action_pressed("moveRight"):
			velocity.x += moveSpeed
			sprite.flip_h = false
		if Input.is_action_pressed("jump") and grounded:
			velocity.y += jumpForce
			
		move_and_slide()
		grounded = false
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision.get_collider().is_in_group("Platform"):
				grounded = true
		
		updateAnimation()
	
func updateAnimation():
	if grounded:
		if velocity.x == 0:
			ap.play("idle")
		else:
			ap.play("move")
	else:
		ap.play("jump")

func setPause(isPaused):
	ap.stop(isPaused)
	paused = isPaused
	
	
