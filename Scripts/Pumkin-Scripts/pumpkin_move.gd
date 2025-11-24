extends CSGSphere3D


@onready var onVine = true
@onready var inHand = false
@onready var inSling = false
var startHeight = global_position.y
var totalDrop = 0
#var getNewSpawn = get_parent().hasSpawned
var goSpawnPump = false
#@onready var pumptimer
#@onready var pumptimer = $Timer
signal newPumpkin

func _physics_process(delta: float) -> void:
	#if onVine == false:
		#pumptimer.start()
	
	if onVine == false && inHand == false && inSling == false:
		global_position.y -= delta*1
		
		if global_position.y < -1:
			emit_signal("newPumpkin")
			goSpawnPump = true
			queue_free()
			print("Pumpkin has been Dropped")
		#totalDrop += abs(delta*1)
		#
		#if totalDrop > 10:
			#queue_free()
			#print("Pumpkin has been dropped")
		 	


#func _on_timer_2_timeout() -> void:
	#onVine = false
	##pass # Replace with function body.
