#extends CSGCylinder3D
extends Node3D

@onready var pumpkinSpawn = load("res://Scenes/Objects/pumpkin.tscn")
var hasSpawned = false
@onready var endOfVine = get_node("EndVine")
var positionOfPump = Vector3.ZERO
var truePumpkin = null
#signal newPumpkin

func _physics_process(delta: float) -> void:
	if truePumpkin != null:
		if truePumpkin.inHand == true:
			truePumpkin = null
			$Timer.start()
			
	#positionOfPump = endOfVine.global_position  
	##self.newPumpkin.connect(spawnNewPumpkin)
	#if hasSpawned == false:
		#hasSpawned = true
		#var pumpkin_instance = pumpkinSpawn.instantiate()
		#
		#get_tree().root.add_child(pumpkin_instance)
		#
		#pumpkin_instance.global_position = positionOfPump
		#truePumpkin = pumpkin_instance
	
	#if truePumpkin.goSpawnPump == true:
		#hasSpawned = true	

		

func spawnNewPumpkin():
	hasSpawned = false 


func _on_timer_timeout() -> void:
	positionOfPump = endOfVine.global_position  
	#self.newPumpkin.connect(spawnNewPumpkin)
	var pumpkin_instance = pumpkinSpawn.instantiate()	
	get_tree().root.add_child(pumpkin_instance)
	var pumpkin_instance2 = pumpkin_instance.get_node("PumpkinModel")
	pumpkin_instance2.global_position = positionOfPump
	truePumpkin = pumpkin_instance2
	
	#pass # Replace with function body.
