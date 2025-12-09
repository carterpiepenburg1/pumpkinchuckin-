extends Node3D


var onVine = true
var inHand = false
var inSling = false
var flung = false

var velocity = Vector3(0, 0, 0)
var gravity = Vector3(0, -9.8, 0)
var startPos = Vector3(0, 0, 0)
var time = 0.0

@onready var dotTimer = $DotTimer
@onready var dot = load("res://Scenes/Objects/dot.tscn")

func _physics_process(delta: float) -> void:
	
	if (onVine == false && inHand == false && inSling == false) || flung == true:
		if flung && dotTimer.is_stopped():
			dotTimer.start()
		time += delta
		global_position = startPos + velocity * time + 0.5 * gravity * time * time
	else:
		velocity = Vector3(0, 0, 0)
	
	if global_position.y < 0:
			queue_free()


func _on_dot_timer_timeout() -> void:
	
	#Create dot
	var newDot = dot.instantiate()
	newDot.global_position = global_position
	get_tree().current_scene.add_child(newDot)
