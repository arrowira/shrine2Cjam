extends Control

var mouseIn = false
var defaulty
var defaultx

var id = -1 #-1 = null, 0 = hitMult, 1 = parryHitMult, 2 = speedMult, 3 = add heart, 4 = kbMult, 5 = heart spawn
var text = ""
@onready var main = $"../../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	defaulty = $ColorRect.position.y
	defaultx = $ColorRect.position.x
	initializeID(randi_range(0,5))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouseIn:
		$ColorRect.position.y = defaulty - 10
		$ColorRect.position.x = defaultx + 10
	else:
		$ColorRect.position.y = defaulty
		$ColorRect.position.x = defaultx
	
	if mouseIn and Input.is_action_just_pressed("attack"):
		match id:
			0:
				main.hitMultiplier+=0.2
			1:
				main.parryHitMultiplier += 0.2
			2:
				main.speedMultiplier += 0.2
			3:
				main.addHeart()
			4:
				main.kbMultiplier += 0.2
			5:
				main.heartChance += 0.1
		$"..".visible=false
		$"../../../SFX/upgrade".play()
		Engine.time_scale = 1
				

func initializeID(num):
	id = num
	match id:
		0:
			text = "increased damage on normal hit"
		1:
			text = "increased damage on hit after parry"
		2:
			text = "increased player speed"
		3:
			text = "increase max health"
		4:
			text = "increased sword knockback"
		5:
			if main.heartChance == 0:
				text = "shrine has a chance to spawn health after a wave"
			else:
				text = "increased chance to spawn health after a wave"
	$ColorRect/RichTextLabel.text = text

func _on_color_rect_mouse_entered() -> void:
	mouseIn = true
	
	


func _on_color_rect_mouse_exited() -> void:
	mouseIn = false
