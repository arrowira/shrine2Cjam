extends Control



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_settings_pressed() -> void:
	$CamMov.global_position = $SettingsPos.global_position


func _on_back_2_pressed() -> void:
	$CamMov.global_position = $MainPos.global_position


func _on_htp_pressed() -> void:
	$CamMov.global_position = $HTPPos.global_position
