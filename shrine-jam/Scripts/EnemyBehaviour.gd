extends CharacterBody2D

var state = "idle"
var playerPos
var playerDist
var playerDir 
var movementDir = Vector2.ZERO
var speed = 0 
var aggro = false

func _process(delta: float) -> void:
	playerPos = get_tree().current_scene.playerPos
	playerDist = global_position.distance_to(playerPos)
	playerDir = (playerPos-global_position).normalized()
	
	if movementDir.x >= 0:
		$Sprite.scale.x = -8
	elif movementDir.x <= 0:
		$Sprite.scale.x = 8
	
	if playerDist < 800:
		aggro = true

func _physics_process(delta: float) -> void:
	$Label.text = state
	position += movementDir*speed
	if state == "pursue":
		movementDir = playerDir
	if state == "pounce":
		movementDir = playerDir.orthogonal()
	if state == "attacking":
		speed = 10 * $AttackTimer.time_left/$AttackTimer.wait_time
	if state == "retreat":
		movementDir = -playerDir
	if state == "retreat" or state == "pursue" or state == "pounce":
		$AnimationPlayer.play("walk")
	if state == "idle":
		$AnimationPlayer.play("idle")
	
		
		

	
	
	
var coin = 1
func _on_mood_clock_timeout() -> void:
	var mood = randf()
	
	if aggro == false:
		if mood < 0.4:
			movementDir = Vector2(1,0) * coin
			speed = 3
		elif mood < 0.6:
			speed = 0
			coin *= -1
	else:
		#aggro
		if state != "attacking":
			if mood < 0.5:
				if playerDist > 300:
					#walk towards player
					state = "pursue"
					speed = 3
				else:
					state = "pounce"
					speed = 2
			elif mood < 0.7:
				if state == "pounce":
					#attack
					state = "attacking"
					$AttackTimer.start()
					movementDir = playerDir
	


func _on_attack_timer_timeout() -> void:
	print("retreat")
	state = "retreat"
	speed = 3
