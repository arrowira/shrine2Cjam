extends CharacterBody2D

@export var speed = 100
var input

var isDashing = false
var dashSpeed = 0
var dashDir = Vector2(0,0)

func _physics_process(delta: float) -> void:
	input = Input.get_vector("left", "right", "up", "down")
	
	if isDashing:
		velocity += dashDir*dashSpeed
		velocity *= 0.8
	else:
		velocity += input * speed
		velocity *= 0.8
	
	if Input.is_action_just_pressed("attack") and $SwordPivot.returning==false:
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
