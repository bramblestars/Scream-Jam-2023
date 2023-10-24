extends CharacterBody2D

var moveSpeed : float = 150.0
var jumpForce : float = 400.0
var gravity : float = 600.0
var hitSpikes : bool = false
var nextLevel : bool = false
var paused : bool = false
var timerStopped : bool = true

@onready var respawnX = position.x
@onready var respawnY = position.y
@onready var sprite : Sprite2D = $Sprite
@onready var ap : AnimationPlayer = $AnimationPlayer
@onready var jumpScareAnim : AnimatedSprite2D = $JumpscareAnimation
@onready var canvas : CanvasLayer = get_parent().get_node("OptionCanvas")
@onready var respawnTimer : Timer = $Timer
@export var shadowLevel : bool = false
@export var level : Node2D
@export var extraMusic : AudioStreamPlayer2D

var inventory = {}

var score : int = 0

func _ready():
	jumpScareAnim.hide()
	
func _physics_process(delta):
	if not paused and timerStopped:
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
		if Input.is_action_just_pressed("jump") and is_on_floor():
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
	

func respawn():
	position.x = respawnX
	position.y = 502
	velocity.y = 0
	respawnTimer.start()
	timerStopped = false

func gameOver():
	Global.music_progress = Music.get_playback_position()
	if shadowLevel:
		Global.dark_music_progress = extraMusic.get_playback_position()
	get_tree().reload_current_scene()
	
func addObject(item):
	if item not in inventory:
		inventory[item] = 0
	inventory[item] = inventory[item] + 1
	
func setPause(isPaused):
	ap.stop(isPaused)
	paused = isPaused
	
func jumpScare():
	if canvas and not hitSpikes:
		canvas.hide()
	$StaticSFX.play()
	jumpScareAnim.show()
	jumpScareAnim.speed_scale = 1.5
	jumpScareAnim.play("default")
	paused = true
	
func _on_jumpscare_animation_animation_finished():
	if hitSpikes:
		hitSpikes = false
		paused = false
		respawn()
		jumpScareAnim.hide()
	elif nextLevel:
		nextLevel = false
		paused = false
		get_tree().change_scene_to_file(level.nextLevelFilePath)
	else:
		gameOver()

func _on_timer_timeout():
	timerStopped = true
