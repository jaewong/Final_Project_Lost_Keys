# PlayerData.gd
# Autoloaded script/can access in any script
# Some code is referenced from tutorials stated in README file 
extends Node

signal score_updated
signal player_died
signal obtained_key
signal door_status
signal num_of_keys

# Score Variable with setter
var score: = 0 setget set_score
# The number of points player has earned in scene so far 
var scene_score: = 0
# Death Variable
var deaths: = 0 setget set_deaths
# Player died variable 
var p_died: = false
# Obtaining Key 
var pickup_key: = false setget set_key
var key_num = 0 setget set_keynum
# Check Door variable
var tried_door: = false setget set_door

# reset function 
func reset() -> void:
	score = 0
	deaths = 0
	key_num = 0
	pickup_key = false
	tried_door = false

# Set Signal Variables
func set_score(value: int) -> void:
	score = value
	print(score)
	emit_signal("score_updated")
	
func set_deaths(value: int) -> void:
	deaths = value
	print(deaths)
	emit_signal("player_died")
	
func set_key(value: bool) -> void:
	pickup_key = value
	emit_signal("obtained_key")
	
func set_door(value: bool) -> void:
	tried_door = value
	emit_signal("door_status")
	
func set_keynum(value: int) -> void:
	key_num = value
	emit_signal("num_of_keys")
