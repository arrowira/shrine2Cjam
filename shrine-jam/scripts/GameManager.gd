extends Node2D

var shrineRadius = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(3):
		$CanvasLayer/HeartContainer.addHeart()

var playerPos = Vector2(0,0)
var playerSpeed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ShrineBorder.change_radius(shrineRadius)
	playerSpeed = $Player.velocity.length()/400
	playerPos = $Player.global_position

func takeDamage():
	$CanvasLayer/HeartContainer.takeDamage()

func enemyKilled():
	shrineRadius += 0.005
