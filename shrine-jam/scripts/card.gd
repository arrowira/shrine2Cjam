extends Control

var mouseIn = false
var defaulty
var defaultx

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	defaulty = $ColorRect.position.y
	defaultx = $ColorRect.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouseIn:
		$ColorRect.position.y = defaulty - 10
		$ColorRect.position.x = defaultx + 10
	else:
		$ColorRect.position.y = defaulty
		$ColorRect.position.x = defaultx


func _on_color_rect_mouse_entered() -> void:
	mouseIn = true
	
	


func _on_color_rect_mouse_exited() -> void:
	mouseIn = false
