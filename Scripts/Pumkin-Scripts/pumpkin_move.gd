extends Node3D


var onVine = true
var inHand = false
var inSling = false
var flung = false

var velocity = Vector3(0, 0, 0)
var gravity = Vector3(0, -9.8, 0)
var startPos = Vector3(0, 0, 0)
var time = 0.0

func _process(delta: float) -> void:
	
	if (onVine == false && inHand == false && inSling == false) || flung == true:
		time += delta
		global_position = startPos + velocity * time + 0.5 * gravity * time * time
	else:
		velocity = Vector3(0, 0, 0)
	
	if global_position.y < 0:
			queue_free()
			print("Pumpkin has been Dropped")
