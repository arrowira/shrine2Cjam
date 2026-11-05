extends Node2D
var speed = 10
var parried = false
func _ready() -> void:
	look_at(get_tree().current_scene.playerPos)
func _physics_process(delta: float) -> void:
	position += speed*Vector2(cos(rotation),sin(rotation))
