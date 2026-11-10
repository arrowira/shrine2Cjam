extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dash") or Input.is_action_just_pressed("attack") or Input.is_action_just_pressed("block"):
		visible = false
		Engine.time_scale = 1
	if visible:
		Engine.time_scale = 0.3


func _on_play_pressed() -> void:
	visible=false
	Engine.time_scale = 1
