extends Node2D

var shrineRadius = 0.05
var spacialRadius = 0.05*13000

var pGrunt = preload("res://Scenes/Grunt.tscn")
var pArcher = preload("res://Scenes/sorcerer.tscn")
var pSkelly = preload("res://Scenes/Swordsman.tscn")

var wave = 0
var waveEnemyAmt = 1
var currentEnemies = 1
var spawnFrequencies = [1,0,0] #grunts, archers, skellies

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buildWave(waveEnemyAmt)
	for i in range(3):
		$CanvasLayer/HeartContainer.addHeart()

var playerPos = Vector2(0,0)
var playerSpeed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spacialRadius = shrineRadius * 13000
	$ShrineBorder.change_radius(shrineRadius)
	playerSpeed = $Player.velocity.length()/400
	playerPos = $Player.global_position

func takeDamage():
	$CanvasLayer/HeartContainer.takeDamage()

func enemyKilled():
	currentEnemies -=1
	$EnemyNumber.text = str(currentEnemies)
	if currentEnemies == 0:
		#wave completed
		shrineRadius += 0.005
		waveEnemyAmt +=1
		currentEnemies = waveEnemyAmt
		buildWave(waveEnemyAmt)
		raiseFrequencies()
		print(spawnFrequencies)
		
func raiseFrequencies():
	if spawnFrequencies[0]>=0:
		if randf()<0.5:
			var amt = spawnFrequencies[0]*randf_range(0,0.1)
			if randf()<0.75:
				spawnFrequencies[1] += amt
			else:
				spawnFrequencies[2] += amt
			spawnFrequencies[0] -= amt
			

func buildWave(num):
	for i in range(num):
		await get_tree().create_timer(0.1).timeout
		
		var roll = randf()
		
		$EnemyNumber.text = str(int($EnemyNumber.text) + 1)
		
		if roll < spawnFrequencies[0]:
			spawnEnemy("grunt")
		elif roll < spawnFrequencies[0]+spawnFrequencies[1]:
			spawnEnemy("archer")
		elif roll < spawnFrequencies[0]+spawnFrequencies[1]+spawnFrequencies[2]:
			spawnEnemy("skelly")

func spawnEnemy(type):
	var enemy
	if type == "grunt":
		enemy = pGrunt.instantiate()
	elif type == "skelly":
		enemy = pSkelly.instantiate()
	elif type == "archer":
		enemy = pArcher.instantiate()
	var theta = randf_range(0, 2*PI)
	var r = randf_range(100, spacialRadius - 100)
	enemy.global_position = r*Vector2(cos(theta),sin(theta))
	add_child(enemy)
	
	
