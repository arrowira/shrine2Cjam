extends CharacterBody2D

@export var speed = 0
var input


func _physics_process(delta: float) -> void:
	input = Input.get_vector("left", "right", "up", "down")
	velocity += input * speed

	move_and_slide()
