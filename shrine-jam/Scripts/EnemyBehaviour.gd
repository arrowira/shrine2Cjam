extends CharacterBody2D

var player

var speed = 2
var aggroDistance = 1000
var campDistance = 300
var dashInterval = 360

var idlePoint = Vector2.ZERO
var wandering = false
var moveAround = false
var angry = false
var camping = false
var dashing = false
var time = 0
var rot = 0
var acrossCircle

func _ready():
	player = get_tree().current_scene.get_node("Player")

func _physics_process(float) -> void:
	if(global_position.distance_to(player.global_position) < aggroDistance && angry == false):
		print("hellO")
		wandering = false
		angry = true
	else:
		wandering = true
	
	print(angry)
	if(angry == true && camping == false && dashing == false):
		if(global_position.distance_to(player.global_position) < campDistance):
			camping = true
		global_position = global_position.move_toward(player.global_position, speed)
		
	if(camping == true):
		time+=1
		rot +=0.001
		if(time % dashInterval == 0):
			time = 0
			rot = 0
			dashing = true
			camping = false
		var angle = atan2(player.global_position.y - global_position.y, player.global_position.x - global_position.x) +(rot)
		var cPos = Vector2(cos(angle), sin(angle)) * campDistance
		global_position = player.global_position + cPos
		acrossCircle = player.global_position + (Vector2(cos(angle+PI), sin(angle+PI)) * campDistance)
	
	if(dashing == true):
		if(global_position.distance_to(acrossCircle*3) < 20):
			dashing = false
		global_position = global_position.move_toward(acrossCircle*3, speed*10)
		
	
	if(wandering == true):
		if(randi_range(1, 1000) && idlePoint == Vector2.ZERO || global_position.distance_to(idlePoint) < 20):
			idlePoint = global_position + Vector2(randi_range(-100, 100), randi_range(-100, 100))
			moveAround = true
		if(moveAround == true):
			global_position = global_position.move_toward(idlePoint, speed/10)
			if(idlePoint == Vector2.ZERO || global_position.distance_to(idlePoint) < 20):
				moveAround = false
				
	if(velocity.x > 0):
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = true
	
	move_and_slide()
		
		
