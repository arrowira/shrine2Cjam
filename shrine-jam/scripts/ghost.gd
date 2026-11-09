extends Node2D

var t = 0
func _physics_process(delta: float) -> void:
	t+= 1
	var dir = global_position.normalized()
	var distance = pow(pow(global_position.x,2)+pow(global_position.y,2),0.5)
	
	$spritePivot/scalePivot.scale.y=( (distance)/(distance+200))
	
	$spritePivot.look_at(Vector2(0,0))
	position -= dir * (t/10.0)
	
	
	if global_position.length() <= 10:
		queue_free()
		get_tree().current_scene.enemyKilled()
		
