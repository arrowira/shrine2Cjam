extends CharacterBody2D


func _process(delta: float) -> void:
	velocity *= 0.9
	move_and_slide()



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "SwordHurtBox":
		if area.get_parent().get_parent().isSwinging:
			velocity = (global_position-get_tree().current_scene.playerPos).normalized() * 500
			print('hit')
