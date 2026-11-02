extends CharacterBody2D

@export var speed = 100
var input


func _physics_process(delta: float) -> void:
	input = Input.get_vector("left", "right", "up", "down")
	velocity += input * speed
	velocity *= 0.8
	
	if Input.is_action_just_pressed("attack"):
		$SwordPivot.swing()
	
	move_and_slide()
	
