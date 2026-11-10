extends Node2D

var playerPos = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time sincse the previous frame.
func _process(delta: float) -> void:
	playerPos =  get_tree().current_scene.playerPos
	
var t = 0
func _physics_process(delta: float) -> void:
	t+= 0.02
	position += (playerPos-global_position).normalized()*(t+1)


func _on_heart_area_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitBox":
		get_tree().current_scene.heal()
		queue_free()
