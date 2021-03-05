# Quit Button
extends Button

# Quit button to exit out of game
func _on_QuitButton_pressed() -> void:
	get_tree().quit()
