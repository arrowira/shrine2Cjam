extends Node2D

@onready var weaponRotDynamics: DynamicsSolver = Dynamics.create_dynamics(8.0, 0.8, 2.0)
var pivotDeg = 0
var defaultDeg = 50
var returning = false
var isSwinging = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if isSwinging:
		$SwingPivot/SwordHurtBox.visible = true
	else:
		$SwingPivot/SwordHurtBox.visible = false
	look_at(get_global_mouse_position())
	
	if returning:
		var returnMod = ($ReturnTimer.time_left/$ReturnTimer.wait_time)
		$SwingPivot.rotation_degrees = weaponRotDynamics.update((pivotDeg-defaultDeg)*returnMod+defaultDeg)
		if $SwingPivot.position.y != 0:
			$SwingPivot.position.y = -80*returnMod
	else:
		var h = $ComboTimer.wait_time-$ComboTimer.time_left
		isSwinging = h<0.2
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
			pivotDeg = -60
		1:
			pivotDeg = 60
		2:
			pivotDeg = 0
	
	if attack != 2:
		attack+=1
	
	$ComboTimer.start()


func _on_combo_timer_timeout() -> void:
	r()
func r():
	returning = true
	$ReturnTimer.start()
	attack = 0 
func _on_return_timer_timeout() -> void:
	pivotDeg = defaultDeg
	$SwingPivot.position.y = 0
	returning = false


func _on_block_timer_timeout() -> void:
	r()
