extends Control




func _on_new_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")



	
func _on_rules_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/explains.tscn")




func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn")




func _on_quit_pressed() -> void:
	get_tree().quit()

	
	
