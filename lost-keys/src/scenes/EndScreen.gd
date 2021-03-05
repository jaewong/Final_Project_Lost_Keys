# EndScreen.gd
# Code for End Screen 
extends Control

onready var label: Label = get_node("Label")

# Update end screen scores and deaths 
func _ready() -> void:
	label.text = label.text % [PlayerData.score, PlayerData.deaths]
