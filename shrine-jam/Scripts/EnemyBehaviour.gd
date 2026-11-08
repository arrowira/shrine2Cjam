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
	
	position += movementDir*speed
	if state == "pursue":
		$AnimationPlayer.play("walk")
		movementDir = playerDir
	if state == "pounce" or state == "idle":
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
		if mood < 0.5:
			if playerDist > 300:
				#walk towards player
				state = "pursue"
				speed = 3
			else:
				state = "pounce"
				speed = 0
		elif mood < 0.7:
			if state == "pounce":
				#attack
				speed = 10
				movementDir = playerDir
	
