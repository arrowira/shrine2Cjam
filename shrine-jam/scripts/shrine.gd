extends Node2D

@onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("idle")
	z_index = (global_position.y-80)

func activate():
	anim.play("active")
	$AudioStreamPlayer.play()
