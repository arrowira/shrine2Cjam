extends Node2D

var filled = false

func flip():
	if filled:
		filled = false
		$Heartsprite.frame = 1
	else:
		filled = true
		$Heartsprite.frame = 0

func enable():
	filled = true
	$Heartsprite.frame = 0
func disable():
	filled = false
	$Heartsprite.frame = 1
