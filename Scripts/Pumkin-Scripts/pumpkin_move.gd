extends Node3D


var onVine = true
var inHand = false
var inSling = false
var flung = false

var velocity = Vector3(0, 0, 0)
var gravity = 9.8

var angle = 0
var speed = 0

func _process(delta: float) -> void:
	
	if (onVine == false && inHand == false && inSling == false) || flung == true:
		velocity.y -= gravity * delta
		global_position += velocity * delta
	else:
		velocity = Vector3(0, 0, 0)
	
	if global_position.y < 0:
			queue_free()
			print("Pumpkin has been Dropped")
