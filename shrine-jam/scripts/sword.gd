extends Node2D

@onready var weaponRotDynamics: DynamicsSolver = Dynamics.create_dynamics(8.0, 0.8, 2.0)
var pivotDeg = 0
var returning = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if returning:
		var returnMod = ($ReturnTimer.time_left/$ReturnTimer.wait_time)
		print(returnMod)
		$SwingPivot.rotation_degrees = weaponRotDynamics.update(pivotDeg*returnMod)
		if $SwingPivot.position.y != 0:
			$SwingPivot.position.y = -80*returnMod
	else:
		$SwingPivot.rotation_degrees = weaponRotDynamics.update(pivotDeg)

var attack = 0

func block():
	weaponRotDynamics = Dynamics.create_dynamics(8.0, 0.3, 2.0)
	pivotDeg = 90
	$SwingPivot.position.y = -80
	$BlockTimer.start()
	$ParryTimer.start()
func swing():
	weaponRotDynamics = Dynamics.create_dynamics(8.0, 0.3, 2.0)
	match attack:
		0:
			print("a0")
			pivotDeg = -60
		1:
			pivotDeg = 60
		2:
			pivotDeg = 0
	attack+=1
	if attack == 3:
		r()
	else:
		$ComboTimer.start()


func _on_combo_timer_timeout() -> void:
	r()
func r():
	returning = true
	$ReturnTimer.start()
	attack = 0 
func _on_return_timer_timeout() -> void:
	pivotDeg = 0
	returning = false


func _on_block_timer_timeout() -> void:
	r()
