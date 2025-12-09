extends Node3D

@onready var advanceTimer = $AdvanceTimer

#Make list of all enemy types
@onready var scarecrow = load("res://Scenes/Objects/scarecrow.tscn")
@onready var ghost = load("res://Scenes/Objects/ghost.tscn")
@onready var crow = load("res://Scenes/Objects/crow.tscn")

signal enemy_advance()

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	advanceTimer.wait_time = Globals.advanceTime

func _on_advance_timer_timeout() -> void:
	spawnEnemies()
	enemy_advance.emit()

func spawnEnemies():
	for i in range(0, Globals.enemiesPerRow):
		if rng.randf() < Globals.enemyDensity:
			#spawning enemy
			var enemyType = rng.randi_range(1, 2)
			var newEnemy
			if enemyType == 1:
				newEnemy = scarecrow.instantiate()
			else:
				newEnemy = ghost.instantiate()

			get_tree().current_scene.add_child(newEnemy)
			newEnemy.global_position = Vector3(((i / float(Globals.enemiesPerRow - 1)) - 0.5) * Globals.rowWidth, 1, -Globals.enemyStartDistance)
			newEnemy.rotation.y = deg_to_rad(270)
