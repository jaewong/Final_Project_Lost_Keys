# Enemy.gd
# Some code is referenced from tutorials stated in README file 
extends KinematicBody2D

# Enemy death animation player
onready var animationPlayer = $AnimationPlayer

# Variables
const GRAVITY = 20
const SPEED = 40
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var score = 5

# Enemy Direction
var direction = 1 # 1 represents right direction 

func _ready() -> void:
	set_physics_process(false)

# Killing/Stomping on Enemy Collision
func _on_StompDetector_body_entered(body) -> void:
	# Checks if enemy collided with player node
		if body.name == "Player":
			# Player node "bounces" or jumps after jumping on enemy
			body.bounce()
			# Makes it is not possible to collide with the enemy after it is stomped on
			get_node("CollisionShape2D").disabled = true
			if PlayerData.p_died == false:
				PlayerData.score += score # Adds to Score
				PlayerData.scene_score += score
			# Players enemy death animation & sound
			animationPlayer.play("death")
			yield(animationPlayer, "animation_finished") 
			queue_free() # "Deletes" enemy node

# Enemy Movement
func _physics_process(delta) -> void:
	# The speed and gravity of enemy node
	velocity.x = SPEED * direction
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	
	# Enemy Hitting a wall
	if is_on_wall():
		direction = direction * -1 # Change Direction 
		$RayCast2D.position.x *= -1
	
	# Enemy Hitting a ledge
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1 # Change Direction 
		$RayCast2D.position.x *= -1

# Enemy death sound
func death_sound() -> void:
	if !$EnemyDeath.playing:
		$EnemyDeath.play()
