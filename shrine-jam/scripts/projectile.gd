extends Node2D

func _ready() -> void:
	look_at(get_tree().current_scene.playerPos)
func _physics_process(delta: float) -> void:
	position += 4*Vector2(cos(rotation),sin(rotation))
