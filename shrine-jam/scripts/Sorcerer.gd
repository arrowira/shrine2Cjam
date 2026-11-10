extends CharacterBody2D

var Blood = preload("res://Scenes/Blood.tscn")
var state = "idle"
@onready var area_2d: Area2D = $Area2D

var pProjectile = preload("res://Scenes/Projectile.tscn")
var pGhost = preload("res://Scenes/sorcerer_ghost.tscn")
var playerPos
var playerDist
var movementDir = Vector2(0,0)
var speed = 2
var health = 100
var dead = false

func _process(delta: float) -> void:
	playerPos = get_tree().current_scene.playerPos
	playerDist = global_position.distance_to(playerPos)
	velocity *= 0.9
	$hp.value = health
	if health <= 0:
		dead = true
		die()
	if Input.is_action_just_pressed("attack") and inSword:
		swordHit()
	
	if speed != 0 and movementDir.length() != 0:
		$AnimationPlayer.play("walk")
	else:
		if state != "shoot":
			$AnimationPlayer.play("idle")
		if playerPos.x-global_position.x > 0:
			$SpritePivot.scale.x = -1
		else:
			$SpritePivot.scale.x = 1
	
		
	
	move_and_slide()
	
func _physics_process(delta: float) -> void:
	position += movementDir*speed*Engine.time_scale
	var distance = pow(pow(global_position.x,2)+pow(global_position.y,2),0.5)
	var radius = get_tree().current_scene.shrineRadius * 13000
	if distance>radius:
		velocity += -(global_position).normalized()*500

func die():
	var ghost = pGhost.instantiate()
	ghost.global_position = global_position
	get_parent().add_child(ghost)
	queue_free()

func swordHit():
	var b = Blood.instantiate()
	get_tree().current_scene.get_node("SFX/EnemyHit").stop()
	get_tree().current_scene.get_node("SFX/EnemyHit").play()
	get_parent().add_child(b)
	b.global_position = global_position
	var D = global_position - get_parent().get_node("Player").global_position
	b.global_rotation = D.angle() 
	b.emitting = true
	health -= 30
	velocity = (global_position-get_tree().current_scene.playerPos).normalized() * 500*(2+get_tree().current_scene.playerSpeed)
	
var inSword = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "SwordHurtBox":
		if area.get_parent().get_parent().isSwinging:
			swordHit()
		inSword = true
			
			
	if (area.name == "ProjectileHurtBox" and area.get_parent().parried):
		health -= 40
		velocity = (global_position-get_tree().current_scene.playerPos).normalized() * 500*(2)

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
	if roll < 0.1 and state!= "shoot":
		#shoot
		state = "shoot"
		$Charge.start()
		$AnimationPlayer.play("shoot")
		
		
	elif roll < walkChance:
		if randf()<0.3:
			dir*=-1
		if playerDist < 650:
			movementDir = (global_position-playerPos).normalized()
		else:
			movementDir = ((global_position-playerPos).orthogonal() * dir).normalized()
		


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "SwordHurtBox":
		inSword=false


func _on_charge_timeout() -> void:
	var newProjectile = pProjectile.instantiate()
	newProjectile.global_position = global_position
	get_parent().add_child(newProjectile)
	state = "idle"
