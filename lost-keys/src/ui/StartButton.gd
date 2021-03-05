# StartButton.gd
tool
extends Button

# choose which file/scene is played next after hiting button
export(String, FILE) var next_scene_path = ""

# Start Button to start game/change scenes 
func _on_StartButton_button_up() -> void:
	# resets player data (ui)
	PlayerData.reset()
	get_tree().paused = false
	# moves to a new scene 
	get_tree().change_scene(next_scene_path)

# Error message that no file was selected for the button to go to a new scene
# Suggested through the GDQuest Tutorial 
func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the bottom to work" if next_scene_path == ""else""
# Some code is referenced from tutorials stated in README file 
