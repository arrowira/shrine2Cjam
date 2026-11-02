extends CharacterBody2D

var speed = 10
var dashDistance
var aggroDistance = 500
var campDistance
var dashInterval

var idlePoint = Vector2.ZERO
var wandering = false
var moveAround = false
var angry = false

func _physics_process(float) -> void:
	if(global_position.distance_to(get_tree().current_scene.get_node("Player").global_position) < aggroDistance && angry == false):
		wandering = false
		angry == true
	else:
		wandering = true
	
		
	
	if(wandering == true):
		if(randi_range(1, 1000) && idlePoint == Vector2.ZERO || global_position.distance_to(idlePoint) < 20):
			idlePoint = global_position + Vector2(randi_range(-100, 100), randi_range(-100, 100))
			moveAround = true
		if(moveAround == true):
			global_position = global_position.move_toward(idlePoint, speed/10)
			if(idlePoint == Vector2.ZERO || global_position.distance_to(idlePoint) < 20):
				moveAround = false
				
	if(velocity.x > 0):
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = true
	
	move_and_slide()
		
		
