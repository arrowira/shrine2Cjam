extends Node



var hearts = []
var pHeart = preload("res://Scenes/Heart.tscn")
var health = 0
@export var myColor = "blue"

func addHeart():
	var heart
	heart=pHeart.instantiate()
	heart.disable()
	heart.position = Vector2(len(hearts)*40 + 40, 21)
	hearts.append(heart)
	heal()
	add_child(heart)
	
func takeDamage():
	health -= 1
	flipHeart(health)
	if health == 0:
		get_tree().current_scene.game_over()
		print("player dead")
		
		
func heal():
	if health != len(hearts):
		print("player heals")
		health += 1
		flipHeart(health-1)

func flipHeart(index):
	hearts[index].flip()
