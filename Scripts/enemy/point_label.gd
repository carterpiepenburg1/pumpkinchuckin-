extends Node3D

var points = 0
@onready var label  = $Points
@onready var animationPlayer = $AnimationPlayer

func _ready() -> void:
	
	global_position.y = 1
	
	label.text = "+ " + str(points)
	
	await animationPlayer.animation_finished
	
	queue_free()
