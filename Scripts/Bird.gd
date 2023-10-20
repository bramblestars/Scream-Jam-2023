extends AnimatableBody2D

@export var moveSpeed = 50.0
@export var moveDirection : Vector2 
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

var startPos : Vector2
var targetPos : Vector2
var paused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	startPos = global_position
	targetPos = startPos + moveDirection
	sprite.play("default")
	if moveDirection.x > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(!paused):
		global_position = global_position.move_toward(targetPos, moveSpeed * delta)
		if global_position == targetPos:
			sprite.flip_h = !sprite.flip_h
			if global_position == startPos:
				targetPos = startPos + moveDirection
			else:
				targetPos = startPos
				
func setPause(isPaused):
	paused = isPaused
