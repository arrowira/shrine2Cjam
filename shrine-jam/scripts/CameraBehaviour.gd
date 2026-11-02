extends Camera2D

var defaultFOV
func _ready() -> void:
	defaultFOV = zoom.x

var playerSpeed = 0
var maxNaturalSpeed = 400.0
@onready var effectStrength = 0.02

func _process(delta: float) -> void:
	playerSpeed = get_parent().velocity.length()
	
func _physics_process(delta: float) -> void:
	var zoomMod = maxNaturalSpeed/(playerSpeed*effectStrength + maxNaturalSpeed)
	zoom = Vector2(1,1) * defaultFOV * zoomMod
