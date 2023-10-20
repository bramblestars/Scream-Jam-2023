extends CharacterBody2D


var moveSpeed : float = 100.0
var jumpForce : float = 300.0
var gravity : float = 500
var onGround : bool = false
var paused : bool = false
@onready var sprite : Sprite2D = $Sprite
@onready var ap : AnimationPlayer = $AnimationPlayer
@onready var player : CharacterBody2D = get_parent().get_node("Player")

func _physics_process(delta):
	if not paused:
		#var dir = jumpVersion(delta)
		var dir = floatVersion(delta)
		if dir.x > 0:
			velocity.x += moveSpeed * delta
			sprite.flip_h = true
		else:
			velocity.x -= moveSpeed * delta
			sprite.flip_h = false 
		updateAnimation(dir)
		
func floatVersion(delta):
	var dir = (player.position - self.position).normalized()
	var collision = move_and_collide(dir * moveSpeed * delta)
	if collision:
		if collision.get_collider().is_in_group("Player"):
			collision.get_collider().gameOver()
		else:
			velocity = velocity.slide(collision.get_normal())
	return dir
			
func jumpVersion(delta):
	if not is_on_floor() and position.y < 300:
		velocity.y += gravity * delta
		onGround = false
	else:
		onGround = true
	var dir = (player.position - self.position)
	if dir.y < -5 and onGround:
		velocity.y -= jumpForce 
		onGround = false
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("Player"):
			collision.get_collider().gameOver()
	return dir
	
func updateAnimation(dir):
	if is_on_floor():
		if velocity.x == 0:
			ap.play("idle")
		else:
			ap.play("move")
	else:
		ap.play("jump")

func setPause(isPaused):
	paused = isPaused
