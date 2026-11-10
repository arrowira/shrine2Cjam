extends Control

func createUpgrades():
	visible=true
	Engine.time_scale = 0.05
	$Card.initializeID(generateCardID())
	$Card2.initializeID(generateCardID())
func generateCardID():
	var roll = randf()
	#-1 = null, 0 = hitMult, 1 = parryHitMult, 2 = speedMult, 3 = add heart, 4 = kbMult, 5 = heart spawn
	if roll < 0.15:
		return 0
	elif roll < 0.25:
		return 1
	elif roll < 0.4:
		return 2
	elif roll < 0.55:
		return 3
	elif roll < 0.7:
		return 4
	else:
		return 5
