extends CharacterBody2D

var Blood = preload("res://Scenes/Blood.tscn")
var state = "idle"
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var area_2d: Area2D = $Area2D

var pProjectile = preload("res://Scenes/Projectile.tscn")
var playerPos
var playerDist
var movementDir = Vector2(0,0)
var speed = 2

func _process(delta: float) -> void:
	playerPos = get_tree().current_scene.playerPos
	playerDist = global_position.distance_to(playerPos)
	velocity *= 0.9
	move_and_slide()
	
func _physics_process(delta: float) -> void:
	position += movementDir*speed



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "SwordHurtBox":
		if area.get_parent().get_parent().isSwinging:
			var b = Blood.instantiate()
			get_parent().add_child(b)
			b.global_position = global_position
			var D = global_position - get_parent().get_node("Player").global_position
			b.global_rotation = D.angle() 
			b.emitting = true
			velocity = (global_position-get_tree().current_scene.playerPos).normalized() * 500*(2+get_tree().current_scene.playerSpeed)
			decrease_life_points()
			texture_progress_bar.connect("value_changed", healthbar_changed)
	if (area.name == "ProjectileHurtBox" and area.get_parent().parried):
		decrease_life_points()
		velocity = (global_position-get_tree().current_scene.playerPos).normalized() * 500*(2)
func decrease_life_points():
	texture_progress_bar.value -= 1
			

func healthbar_changed(value : float) -> void:
	if value == 0:
		queue_free()

var dir = 1
func updateBehaviour() -> void:
	movementDir = Vector2(0,0)
	var roll = randf()
	var walkChance
	if playerDist < 400:
		walkChance = 0.8
	else:
		walkChance = 0.3
	if roll < 0.1:
		var newProjectile = pProjectile.instantiate()
		newProjectile.global_position = global_position
		get_parent().add_child(newProjectile)
		
	elif roll < walkChance:
		if randf()<0.3:
			dir*=-1
		if playerDist < 650:
			movementDir = (global_position-playerPos).normalized()
		else:
			movementDir = ((global_position-playerPos).orthogonal() * dir).normalized()
		
