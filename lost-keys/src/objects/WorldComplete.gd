# WorldComplete.gd
# Some code is referenced from tutorials stated in README file 
tool
extends Area2D

# Call AnimationPlayer Node
onready var anim_player: AnimationPlayer = $AnimationPlayer

# Allow to move to next level 
export var next_level: PackedScene

# Collision / detect player
func _on_WorldComplete_body_entered(body) -> void:
	var key = PlayerData.pickup_key
	var got_key = key 
	# Check if player has retrived key 
	if body.name == "Player":
		if got_key == true:
			teleport()
		else:
			PlayerData.tried_door = true # tried to open locked door 
			$LockedDoor.play()

# Warning for no scene added to node
func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_level else ""

# Teleport to next level
func teleport() -> void: 
	PlayerData.pickup_key = false
	PlayerData.key_num = 0
	PlayerData.scene_score = 0
	anim_player.play("fade_in") # Teleport animation & sound
	yield(anim_player, "animation_finished") 
	get_tree().change_scene_to(next_level)

# Teleport audio
func door_sound() -> void:
	if !$Door.playing:
		$Door.play()
