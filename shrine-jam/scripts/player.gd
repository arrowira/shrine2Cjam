extends CharacterBody2D

@export var speed = 100
var input

var isDashing = false
var dashSpeed = 0
var dashDir = Vector2(0,0)
var immune = false
@onready var anim = $AnimationPlayer

func _physics_process(delta: float) -> void:
	var distance = pow(pow(global_position.x,2)+pow(global_position.y,2),0.5)
	var radius = get_tree().current_scene.shrineRadius * 13000
	if distance>radius:
		velocity += -(global_position).normalized()*500
	
	z_index = global_position.y
	
	input = Input.get_vector("left", "right", "up", "down")
	$footstepper.angle_max = atan2(input.x,input.y)
	$footstepper.angle_min = atan2(input.x,input.y)
	if velocity.x >= 0:
		$SpritePivot.scale.x = 1
	elif velocity.x <= 0:
		$SpritePivot.scale.x = -1
	
	if !isDashing:
		if velocity.length()> 300:
			$footstepper.emitting=true
			anim.play("walk")
		else:
			$footstepper.emitting=false
			anim.play("idle")
		
	
	if isDashing:
		velocity += dashDir*dashSpeed
		velocity *= 0.8
	else:
		velocity += input * speed
		velocity *= 0.8
	
	if Input.is_action_just_pressed("attack") and ($SwordPivot/ReturnTimer.time_left < 0.1 or $SwordPivot.returning == false) and $SwordPivot.attack!=3 and $SwingTimer.time_left==0:
		if $SwordPivot.attack == 2:
			dash((get_global_mouse_position()-global_position).normalized(), 10, 5)
			#$SFX/Slash.pitch_scale = randf_range(0.7, 1.1)
			$SFX/Slash.pitch_scale = randf_range(1.4, 2.0)
			$SFX/Slash.volume_db = randf_range(-4, 0)
			$SFX/Slash.play()
		else:
			$SFX/Slash.pitch_scale = randf_range(1.1, 1.4)
			$SFX/Slash.volume_db = randf_range(-4, 0)
			$SFX/Slash.play()
		$SwordPivot.swing()
		$SwingTimer.start()
	
	if Input.is_action_just_pressed("block") and $SwordPivot.returning==false:
		$SwordPivot.block()
	if Input.is_action_just_pressed("dash") and isDashing == false and $DashCD.time_left == 0:
		anim.play('dash')
		$DashCD.start()
		$SFX/Dash.play()
		dash(input,20,5)
		
	move_and_slide()

func dash(dir: Vector2, distance: float, dSpeed: float):
	isDashing=true
	dashDir = dir
	dashSpeed = speed*dSpeed
	$DashTimer.wait_time = 0.01*distance
	$DashTimer.start()
	
func _on_dash_timer_timeout() -> void:
	isDashing=false
func isParrying():
	return $SwordPivot.isParrying

func takeDamage():
	if !immune:
		get_tree().current_scene.get_node("SFX/PlayerHit").stop()
		get_tree().current_scene.get_node("SFX/PlayerHit").play()
		immune = true
		$Recovery.start()
		$Camera2D.shake(5,20)
		get_parent().takeDamage()

func _on_player_hit_box_area_entered(area: Area2D) -> void:
	if area.name == "ProjectileHurtBox":
		if isParrying():
			$SFX/Parry.play()
			$Camera2D.shake(5,5)
			area.get_parent().parried = true
			area.get_parent().speed *= 3
			area.get_parent().rotation = atan2(get_global_mouse_position().y-global_position.y,get_global_mouse_position().x-global_position.x)
		else:
			area.get_parent().queue_free()
			takeDamage()
	if area.name == "GruntHurtBox" or area.name == "SwordsmanHurtBox":
		if isParrying():
			$SFX/Parry.play()

func _on_recovery_timeout() -> void:
	immune = false
