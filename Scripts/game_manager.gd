extends Node3D

@onready var advanceTimer = $AdvanceTimer
@onready var roundTimer = $RoundTimer

#Make list of all enemy types
@onready var scarecrow = load("res://Scenes/Objects/scarecrow.tscn")
@onready var ghost = load("res://Scenes/Objects/ghost.tscn")
@onready var crow = load("res://Scenes/Objects/crow.tscn")

signal enemy_advance()
signal clear_enemies()

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	advanceTimer.wait_time = Globals.advanceTime
	roundTimer.wait_time = Globals.roundTime
	
	advanceTimer.start()
	roundTimer.start()

func _on_advance_timer_timeout() -> void:
	if Globals.roundNum <= 3:
		spawnEnemies()
		enemy_advance.emit()

func spawnEnemies():
	for i in range(0, Globals.enemiesPerRow):
		var guaranteedEnemy = rng.randi_range(0, Globals.enemiesPerRow - 1)
		if i == guaranteedEnemy or rng.randf() < Globals.enemyDensity:
			#spawning enemy based on round
			var enemyType = rng.randi_range(1, Globals.roundNum)
			
			var enemyHeightOffset = 1
			
			var newEnemy
			if enemyType == 1:
				newEnemy = scarecrow.instantiate()
			elif enemyType == 2:
				newEnemy = ghost.instantiate()
			else:
				newEnemy = crow.instantiate()
				enemyHeightOffset = rng.randf_range(1, 3)

			get_tree().current_scene.add_child(newEnemy)
			newEnemy.global_position = Vector3(((i / float(Globals.enemiesPerRow - 1)) - 0.5) * Globals.rowWidth, enemyHeightOffset, -Globals.enemyStartDistance)
			newEnemy.rotation.y = deg_to_rad(270)


func _on_round_timer_timeout() -> void:
	Globals.roundNum += 1
	clear_enemies.emit()
		
