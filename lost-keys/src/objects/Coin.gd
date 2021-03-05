# Coin.gd
# Some code is referenced from tutorials stated in README file 
# Script for coin function (pick-up & adding to player score) 
extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
	
var score = 1

func _on_Coin_body_entered(body: PhysicsBody2D) -> void:
	# Add points to score
	PlayerData.score += score # Adds to Score
	PlayerData.scene_score += score
	# Play pick up audio and animation
	$pick_up_audio.play()
	anim_player.play("pick_up")
	yield(anim_player, "animation_finished") 
	queue_free()
