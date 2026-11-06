extends Camera2D

var defaultFOV
func _ready() -> void:
	defaultFOV = zoom.x

var playerSpeed = 0
var maxNaturalSpeed = 400.0
var shakes = 0
var strength
@onready var effectStrength = 0.01

func _process(delta: float) -> void:
	playerSpeed = get_parent().velocity.length()
	
func _physics_process(delta: float) -> void:
	var zoomMod = maxNaturalSpeed/(playerSpeed*effectStrength + maxNaturalSpeed)
	zoom = Vector2(1,1) * clampf(defaultFOV * zoomMod + 0.01, 0,defaultFOV)

func shake(s, str):
	shakes = s
	strength = str
	$ShakeTimer.start()

func _on_shake_timer_timeout() -> void:
	print("shake")
	strength -= strength*0.1
	offset.x = strength*randf_range(-1,1)
	offset.y = strength*randf_range(-1,1)
	if shakes!=0:
		shakes-=1
		$ShakeTimer.start()
		
