# Key.gd
extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

# Key interactions 
func _physics_process(delta) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			if PlayerData.pickup_key == false: # Change key boolean for door 
				$GetKey.play() # Key pick-up audio
			PlayerData.key_num = 1
			PlayerData.pickup_key = true # key picked up
			anim_player.play("fade_out") # Key animation 
			yield(anim_player, "animation_finished") 
			queue_free()
