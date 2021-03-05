# GameUserInterface.gd
# Some code is referenced from tutorials stated in README file 
extends Control

# Variables
onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var score: Label = get_node("Data/Score")
onready var death: Label = get_node("Data/Deaths")
onready var num_keys: Label = get_node("Data/Num_of_key")
onready var pause_title: Label = get_node("PauseOverlay/Title")
onready var message: Label = get_node("GameMessage")
onready var death_audio = $PlayerDeath

var paused: = false setget set_paused

# Grabbing Player Data
func _ready() -> void:	
	message.text =  "%s" % "Escape."
	PlayerData.connect("door_status", self, "update_message_door")
	PlayerData.connect("obtained_key", self, "update_message_key")
	PlayerData.connect("num_of_keys", self, "update_key_num")
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_PlayerData_player_died")
	PlayerData.connect("player_died", self, "update_interface")
	update_interface()

# Changes text for death screen
func _PlayerData_player_died() -> void:
	death_audio.play()
	self.paused = true
	pause_title.text = "You have died"

# Set up pause button
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and pause_title.text != "You have died":
		self.paused = not paused
		scene_tree.set_input_as_handled()
		
# Setting Pause/Unpause
func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

# Update score
func update_interface() -> void:
	score.text = "Score: %s" % PlayerData.score
	death.text = "Total Deaths: %s" % PlayerData.deaths
	num_keys.text = "x  %s" % PlayerData.key_num

# Updates UI message for locked door 
func update_message_door() -> void:
	if PlayerData.tried_door == true:
		message.text =  "%s" % "The door is locked. Looks like it needs a key..."
		
# When picking up key 
func update_message_key() -> void:
	if PlayerData.pickup_key == true:
		message.text =  "%s" % "Obtained a key."

# Updates the number of keys found
func update_key_num() -> void:
	if PlayerData.pickup_key == true:
		num_keys.text = "x  %s" % PlayerData.key_num
	
