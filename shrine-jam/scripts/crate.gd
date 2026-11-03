extends CharacterBody2D


func _process(delta: float) -> void:
	velocity *= 0.9
	move_and_slide()



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "SwordHurtBox":
		velocity = (get_tree().current_scene.playerPos-global_position).normalized * 5
