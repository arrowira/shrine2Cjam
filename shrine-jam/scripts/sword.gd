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
	else:
		$SwingPivot.rotation_degrees = weaponRotDynamics.update(pivotDeg)

var attack = 0
func swing():
	weaponRotDynamics = Dynamics.create_dynamics(8.0, 0.3, 2.0)
	match attack:
		0:
			print("a0")
			pivotDeg = -40
		1:
			pivotDeg = 40
		2:
			pivotDeg = -40
	attack+=1
	print(attack)
	$ComboTimer.start()


func _on_combo_timer_timeout() -> void:
	returning = true
	$ReturnTimer.start()
	attack = 0 


func _on_return_timer_timeout() -> void:
	pivotDeg = 0
	returning = false
