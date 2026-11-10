extends CharacterBody2D

var Blood = preload("res://Scenes/Blood.tscn")

var state = "idle"
var playerPos
var playerDist
var playerDir 
var movementDir = Vector2.ZERO
var speed = 0 
var aggro = false
var coin = 1
var inPlayer = false
var health = 100
var dead = false
var inSword = false
var preHitState 
var pGhost = preload("res://Scenes/grunt_ghost.tscn")
var canDamage = true


func _process(delta: float) -> void:
	playerPos = get_tree().current_scene.playerPos
	playerDist = global_position.distance_to(playerPos)
	playerDir = (playerPos-global_position).normalized()
	
	if inSword and Input.is_action_just_pressed("attack"):
		swordHit()
	
	$hp.value = health
	if health <= 0:
		dead = true
		die()
	
	if state != "pounce" and  state!= "hit" and state != "pre attack":
		if movementDir.x >= 0:
			$Sprite.scale.x = -5
		elif movementDir.x <= 0:
			$Sprite.scale.x = 5
	else:
		if playerDir.x >= 0:
			$Sprite.scale.x = -5
		elif playerDir.x <= 0:
			$Sprite.scale.x = 5
	
	if playerDist < 800:
		aggro = true
		
func die():
	var ghost = pGhost.instantiate()
	ghost.global_position = global_position
	get_parent().add_child(ghost)
	queue_free()
	
func _physics_process(delta: float) -> void:
	z_index = global_position.y
	var distance = pow(pow(global_position.x,2)+pow(global_position.y,2),0.5)
	var radius = get_tree().current_scene.shrineRadius * 13000
	if distance>radius:
		position += -(global_position).normalized()*500
	
	$Label.text = state
	position += movementDir*speed*Engine.time_scale
	if state == "pursue":
		movementDir = playerDir
	if state == "pounce":
		movementDir = playerDir.orthogonal() * coin
	if state == "pre attack":
		speed = -1
	if state == "attacking":
		speed = 30 * pow($AttackTimer.time_left/$AttackTimer.wait_time, 4)
	if state == "retreat":
		movementDir = -playerDir
	if state == "parried":
		speed = 5 * pow($ParriedTimer.time_left/$ParriedTimer.wait_time, 3)
	if state == "hit":
		speed *= 0.9
		
		
	if state != "attacking":
		if state == "retreat" or state == "pursue" or state == "pounce" or state == "walk":
			$AnimationPlayer.play("walk")
		if state == "idle":
			$AnimationPlayer.play("idle")
	else:
		if inPlayer:
			if get_tree().current_scene.get_node("Player").isParrying() and canDamage:
				state = "parried"
				movementDir= -playerDir
				health -= 10
				$ParriedTimer.start()
				canDamage = false
			else:
				get_tree().current_scene.get_node("Player").takeDamage()
				get_tree().current_scene.get_node("Player").dash(playerDir,3,10)
				canDamage = false
		
	
		
		

func _on_mood_clock_timeout() -> void:
	var mood = randf()
	
	if mood < 0.3:
		coin *= -1
	
	if aggro == false:
		if mood < 0.4:
			movementDir = Vector2(1,0) * coin
			speed = 3
			state = "walk"
		elif mood < 0.6:
			state = "idle"
			speed = 0
	else:
		#aggro
		if state != "attacking" and state != "parried":
			if mood < 0.5:
				if playerDist > 450:
					#walk towards player
					state = "pursue"
					speed = 3
				else:
					state = "pounce"
					canDamage = true
					speed = 2
			elif mood < 0.8:
				if state == "pounce":
					#attack
					state = "pre attack"
					
					$AnimationPlayer.play("attack")
					$PreattackTimer.start()
					movementDir = -playerDir
	


func _on_attack_timer_timeout() -> void:
	if state != "parried":
		state = "retreat"
		speed = 3


func _on_grunt_hurt_box_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitBox":
		inPlayer=true



func _on_grunt_hurt_box_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitBox":
		inPlayer=false


func _on_parried_timer_timeout() -> void:
	state = "idle"
	speed = 0

func swordHit():
	var damage
	var kbStrength
	var b = Blood.instantiate()
	get_tree().current_scene.get_node("SFX/EnemyHit").stop()
	get_tree().current_scene.get_node("SFX/EnemyHit").play()
	add_child(b)
	b.global_position = global_position
	var D = global_position - get_parent().get_node("Player").global_position
	b.global_rotation = D.angle() 
	b.emitting = true
	get_tree().current_scene.get_node("SFX/EnemyHit").stop()
	get_tree().current_scene.get_node("SFX/EnemyHit").play()
	movementDir = -playerDir
	preHitState = state
	if state == "parried":
		damage = 50
		kbStrength = 5
	else:
		damage = 10
		kbStrength = 5
	health-=damage
	state = "hit"
	speed = kbStrength * 3
	
	

func _on_grunt_hit_box_area_entered(area: Area2D) -> void:
	if area.name == "SwordHurtBox":
		if area.get_parent().get_parent().isSwinging:
			swordHit()
		inSword = true
		


func _on_grunt_hit_box_area_exited(area: Area2D) -> void:
	if area.name == "SwordHurtBox":
		inSword = false


func _on_hit_timer_timeout() -> void:
	state = preHitState
	movementDir = playerDir


func _on_preattack_timer_timeout() -> void:
	state = "attacking"
	$AttackTimer.start()
	movementDir=playerDir
