extends Node2D


func _physics_process(delta: float) -> void:
	var dir = global_position.normalized()
	
	position -= dir
	
	if global_position.length() <= 10:
		queue_free()
