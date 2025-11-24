extends Node3D


@onready var onVine = true
@onready var inHand = false
@onready var inSling = false

func _process(delta: float) -> void:
	
	if onVine == false && inHand == false && inSling == false:
		global_position.y -= delta * 3
		
		if global_position.y < -1:
			queue_free()
			print("Pumpkin has been Dropped")
