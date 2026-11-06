extends Node2D
var speed = 10
var parried = false
var t = 0
func _ready() -> void:
	look_at(get_tree().current_scene.playerPos)
func _physics_process(delta: float) -> void:
	t+=0.01
	position += speed*Vector2(cos(rotation),sin(rotation))
	if t>3:
		queue_free()
