extends CharacterBody2D


var moveSpeed : float = 100.0
var jumpForce : float = 500.0
var gravity : float = .5
var onGround : bool = false

@onready var sprite : Sprite2D = $Sprite
@onready var ap : AnimationPlayer = $AnimationPlayer
@onready var player : CharacterBody2D = get_parent().get_node("Player")


func _physics_process(delta):
	# Add the gravity.
	var dir = (player.position - self.position).normalized()
	
	if(!onGround):
		dir.y += gravity
		
	if(dir.x > 0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false

	var collision = move_and_collide(dir * moveSpeed * delta)
	if collision:
		if collision.get_collider().is_in_group("Player"):
			collision.get_collider().gameOver()
		elif collision.get_collider().is_in_group("Platform"):
			print("onground")
			velocity = velocity.slide(collision.get_normal())
			onGround = true
	else:
		print("not on ground")
		onGround = false
	
	
	updateAnimation(dir)

func updateAnimation(dir):
	if is_on_floor():
		if dir.x == 0:
			ap.play("idle")
		else:
			ap.play("move")
	else:
		ap.play("jump")
