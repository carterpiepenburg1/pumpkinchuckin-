extends Node3D

@onready var advanceTimer = $AdvanceTimer
@onready var roundTimer = $RoundTimer

#Make list of all enemy types
@onready var scarecrow = load("res://Scenes/Objects/scarecrow.tscn")
@onready var ghost = load("res://Scenes/Objects/ghost.tscn")
@onready var crow = load("res://Scenes/Objects/crow.tscn")

#Music files
@onready var music1 = load("res://Resources/Sounds/Background Music/758021__audiocoffee__halloween-time-loop-ver.wav")
@onready var music2 = load("res://Resources/Sounds/Background Music/753499__audiocoffee__halloween-background-short-ver.wav")
@onready var music3 = load("res://Resources/Sounds/Background Music/752445__audiocoffee__hard-rock-halloween-loop1.wav")
@onready var musicController = $Music

signal enemy_advance()
signal clear_enemies()

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	advanceTimer.wait_time = Globals.advanceTime
	roundTimer.wait_time = Globals.roundTime
	
	advanceTimer.start()
	roundTimer.start()
	
	musicController.stream = music1
	musicController.play()

func _on_advance_timer_timeout() -> void:
	if Globals.roundNum < 5:
		spawnEnemies()
		enemy_advance.emit()

func spawnEnemies():
	for i in range(0, Globals.enemiesPerRow):
		var guaranteedEnemy = rng.randi_range(0, Globals.enemiesPerRow - 1)
		if i == guaranteedEnemy or rng.randf() < Globals.enemyDensity:
			
			#spawning enemy based on round
			var enemyType
			if Globals.roundNum < 4:
				enemyType = rng.randi_range(1, Globals.roundNum)
			else:
				enemyType = 3
			
			var enemyHeightOffset = 1
			
			var newEnemy
			if enemyType == 1:
				newEnemy = scarecrow.instantiate()
				enemyHeightOffset = 0
			elif enemyType == 2:
				newEnemy = ghost.instantiate()
			else:
				newEnemy = crow.instantiate()
				enemyHeightOffset = rng.randf_range(2, 6)

			get_tree().current_scene.add_child(newEnemy)
			newEnemy.global_position = Vector3(((i / float(Globals.enemiesPerRow - 1)) - 0.5) * Globals.rowWidth, enemyHeightOffset, -Globals.enemyStartDistance)
			newEnemy.rotation.y = deg_to_rad(270)


func _on_round_timer_timeout() -> void:
	Globals.enemyDensity += Globals.enemyDensityIncrease
	Globals.roundNum += 1
	
	if Globals.roundNum == 3:
		musicController.stream = music2
		musicController.play()
	elif Globals.roundNum == 4:
		musicController.stream = music3
		musicController.play()
	elif Globals.roundNum == 5:
		musicController.stop()
		
	clear_enemies.emit()
		
