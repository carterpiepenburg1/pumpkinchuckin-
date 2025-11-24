extends Node3D


@onready var onVine = true
@onready var inHand = false
@onready var inSling = false

@onready var velocity = 0

func _process(delta: float) -> void:
	
	if onVine == false && inHand == false && inSling == false:
		velocity += 2.6 * delta
		global_position.y -= velocity * delta
		
		if global_position.y < 0:
			queue_free()
			print("Pumpkin has been Dropped")
	
	else:
		velocity = 0
