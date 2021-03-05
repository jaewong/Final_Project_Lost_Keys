# Player.gd
# Some code is referenced from tutorials stated in README file 
extends KinematicBody2D

# Variables
const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -470
var motion = Vector2()
var _velocity:= Vector2.ZERO

# Runs animation player
onready var animationPlayer = $AnimationPlayer

# Player Death
func _on_EnemyDetector_body_entered(body) -> void:
	print(body.name)
	if "Enemy" in body.name:
		print("player died")
		die()
		
# Player Movement 
func _physics_process(delta: float) -> void:
	motion.y += GRAVITY
	var friction = false
	
	# Player input movement 
	if Input.is_action_pressed("ui_right"): # Moving Right
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		animationPlayer.play("run")
	elif Input.is_action_pressed("ui_left"): # Moving Left
		motion.x -= ACCELERATION
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		animationPlayer.play("run")
	else: # No Movement/Idle
		friction = true
		motion.x = lerp(motion.x, 0, 0.2)
		animationPlayer.play("idle")
		 
	if is_on_floor(): # Jumping/Falling
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)	
	else:
		if motion.y < 0: # Jump Animation 
			animationPlayer.play("Jump")
		else: # Fall Animation
			animationPlayer.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)	
			
	motion = move_and_slide(motion, UP)
	pass

# Footstep audio
func run_sound() -> void:
	if !$Step.playing:
		$Step.play()

# Players death
func die() -> void:
	PlayerData.deaths += 1
	PlayerData.p_died = true
	queue_free() # Player Disappears

# Player bounce after killing/stomping on an enemy
func bounce() -> void:
	motion.y = JUMP_HEIGHT * 0.7

