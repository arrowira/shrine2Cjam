extends CharacterBody2D

var state = "idle"
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var area_2d: Area2D = $Area2D

func _process(delta: float) -> void:
	velocity *= 0.9
	move_and_slide()



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "SwordHurtBox":
		if area.get_parent().get_parent().isSwinging:
			velocity = (global_position-get_tree().current_scene.playerPos).normalized() * 500*(2+get_tree().current_scene.playerSpeed)
			print('hit')
			area_2d.connect("area_entered", decrease_life_points)
			texture_progress_bar.connect("value_changed", healthbar_changed)
func decrease_life_points(area : Area2D) -> void:
	if area.name == "SwordHurtBox":
		if area.get_parent().get_parent().isSwinging:
			texture_progress_bar.value -= 1

func healthbar_changed(value : float) -> void:
	if value == 0:
		queue_free()


func updateBehaviour() -> void:
	var roll = randf()
	if roll < 0.1:
		print("shoot")
	elif roll < 0.3:
		print("walk")
