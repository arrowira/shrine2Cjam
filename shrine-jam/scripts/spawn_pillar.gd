extends Node2D

var t = 1.5

func _physics_process(delta: float) -> void:
	t-= 0.02
	$ColorRect.material.set_shader_parameter("thresh", t)
	if t <= 0:
		queue_free()
