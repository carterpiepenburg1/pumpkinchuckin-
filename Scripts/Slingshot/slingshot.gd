extends Node3D

@onready var sling = $Sling
@onready var slingArea = $Sling/SlingArea
@onready var leftRope = $LeftRope
@onready var rightRope = $RightRope
@onready var leftLog = $LeftLog
@onready var rightLog = $RightLog

#Ropes
var leftRopeSling
var leftRopeLog
var rightRopeSling
var rightRopeLog

@onready var origin = sling.global_position

var loaded = false
var loadedPumpkin = null

var beingGrabbed = false

var deadzoneDistance = 0.1
var launchMult = 40

func _process(delta: float) -> void:
	
	#Updating ropes
	leftRopeSling = Vector3(sling.global_position.x - sling.inner_radius - (sling.outer_radius - sling.inner_radius)/2, sling.global_position.y, sling.global_position.z)
	leftRopeLog = Vector3(leftLog.global_position.x, leftLog.global_position.y + leftLog.height/4, leftLog.global_position.z)
	rightRopeSling = Vector3(sling.global_position.x + sling.inner_radius + (sling.outer_radius - sling.inner_radius)/2, sling.global_position.y, sling.global_position.z)
	rightRopeLog = Vector3(rightLog.global_position.x, rightLog.global_position.y + rightLog.height/4, rightLog.global_position.z)
	
	update_rope(leftRope, leftRopeSling, leftRopeLog)
	update_rope(rightRope, rightRopeSling, rightRopeLog)
	
	#Updating pumpkins position and resetting loaded if it is no longer there
	if loaded && loadedPumpkin != null:
		loadedPumpkin.global_position = slingArea.global_position
	else:
		loaded = false
		
	#Checking if sling is being grabbed
	if !beingGrabbed:
		sling.global_position = lerp(sling.global_position, origin, delta*20)
		
		#if loaded and out of pull back deadzone shoot pumpkin once you get back to pull back deadzone
		#when shooting pumpkin make sure to turn pumpkin area back on
		if loaded && loadedPumpkin != null && sling.global_position.distance_to(origin) > deadzoneDistance:
			var area = loadedPumpkin.get_node("PumpkinArea")
			
			print("flung pumpkin")
			
			loadedPumpkin.speed = sling.global_position.distance_to(origin)
			var direction = (origin - sling.global_position).normalized()
			loadedPumpkin.velocity = direction * loadedPumpkin.speed * launchMult
			
			
			loadedPumpkin.flung = true
			loadedPumpkin.inSling = false
			
			area.monitorable = true
			area.monitoring = true
			
			loaded = false
			loadedPumpkin = null
	

func update_rope(cylinder, start, end):
	var dir = end - start
	cylinder.global_position = start + dir * 0.5
	cylinder.height = dir.length()
	cylinder.look_at(end, Vector3.RIGHT)

func _on_sling_area_area_entered(area: Area3D) -> void:
	if !loaded && area.name == "PumpkinArea":
		var pumpkin = area.get_parent()
		if pumpkin.inSling == false && pumpkin.flung == false:
			pumpkin.inSling = true
			area.monitorable = false
			area.monitoring = false
				
			loaded = true
			loadedPumpkin = pumpkin
