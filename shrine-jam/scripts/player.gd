extends CharacterBody2D

@export var speed = 100
var input

var isDashing = false
var dashSpeed = 0
var dashDir = Vector2(0,0)

func _physics_process(delta: float) -> void:
	z_index = global_position.y
	
	input = Input.get_vector("left", "right", "up", "down")
	
	if isDashing:
		velocity += dashDir*dashSpeed
		velocity *= 0.8
	else:
		velocity += input * speed
		velocity *= 0.8
	
	if Input.is_action_just_pressed("attack") and ($SwordPivot/ReturnTimer.time_left < 0.1 or $SwordPivot.returning == false):
		if $SwordPivot.attack == 2:
			dash((get_global_mouse_position()-global_position).normalized(), 10, 5)
		$SwordPivot.swing()
	
	if Input.is_action_just_pressed("block") and $SwordPivot.returning==false:
		$SwordPivot.block()
	if Input.is_action_just_pressed("dash") and isDashing == false:
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


func _on_player_hit_box_area_entered(area: Area2D) -> void:
	if area.name == "ProjectileHurtBox":
		if $SwordPivot.isParrying:
			area.get_parent().parried = true
			area.get_parent().speed *= 3
			area.get_parent().rotation = atan2(get_global_mouse_position().y-global_position.y,get_global_mouse_position().x-global_position.x)
		else:
			get_parent().takeDamage()
			area.get_parent().queue_free()
