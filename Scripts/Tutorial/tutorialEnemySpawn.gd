extends Node3D

@onready var tutorialEnemy = load("res://Scenes/Objects/enemyTutorial.tscn")
@onready var baseNode = get_parent().get_parent()
var spawnedYet = false

func _process(_delta: float) -> void:
	if spawnedYet == false:
		spawnedYet = true
		var instanceOfEnemy = tutorialEnemy.instantiate()
		
		#get_tree().root.add_child(instanceOfEnemy)
		baseNode.add_child(instanceOfEnemy)
		instanceOfEnemy.global_position = global_position
		instanceOfEnemy.global_rotation.y = 80
