# RetryButton.gd
extends Button

# Resets playerdata except deaths & reloads scene
func _on_RetryButton_button_up() -> void:
	PlayerData.score -= PlayerData.scene_score 
	PlayerData.pickup_key = false
	PlayerData.key_num = 0
	PlayerData.scene_score = 0
	PlayerData.p_died = false
	get_tree().paused = false
	get_tree().reload_current_scene()
