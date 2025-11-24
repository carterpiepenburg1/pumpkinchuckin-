extends Node3D

@onready var pumpkinSpawn = load("res://Scenes/Objects/pumpkin.tscn")
var hasSpawned = false
@onready var endOfVine = $VineModel/EndVine
var truePumpkin = null

func _physics_process(delta: float) -> void:
	if truePumpkin != null:
		if truePumpkin.inHand == true:
			truePumpkin = null
			$Timer.start()


func _on_timer_timeout() -> void:
	var positionOfPump = endOfVine.global_position
	var pumpkin_instance = pumpkinSpawn.instantiate()	
	get_tree().root.add_child(pumpkin_instance)
	pumpkin_instance.global_position = positionOfPump
	truePumpkin = pumpkin_instance
