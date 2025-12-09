extends Node3D

@onready var sling = $Sling
@onready var slingArea = $Sling/SlingArea

@onready var target = $Target

@onready var origin = sling.global_position

var loaded = false
var loadedPumpkin = null

var beingGrabbed = false

var deadzoneDistance = 0.1
var launchMult = 40

var velocity
var startPos

func _process(delta: float) -> void:
	
	#Updating pumpkins position and resetting loaded if it is no longer there
	if loaded && loadedPumpkin != null:
		loadedPumpkin.global_position = slingArea.global_position
	else:
		loaded = false
		
	#Checking if sling is being grabbed
	if !beingGrabbed:
		target.visible = false
		sling.global_position = lerp(sling.global_position, origin, delta*20)
		
		#if loaded and out of pull back deadzone shoot pumpkin once you get back to pull back deadzone
		#when shooting pumpkin make sure to turn pumpkin area back on
		if loaded && loadedPumpkin != null && sling.global_position.distance_to(origin) > deadzoneDistance:
			var area = loadedPumpkin.get_node("PumpkinArea")
			
			print("flung pumpkin")
			
			loadedPumpkin.velocity = velocity
			loadedPumpkin.startPos = startPos
			loadedPumpkin.time = 0.0
			
			loadedPumpkin.flung = true
			loadedPumpkin.inSling = false
			
			area.set_deferred("monitorable", true)
			area.set_deferred("monitoring", true)
			
			loaded = false
			loadedPumpkin = null
			
	#Trajectory Prediction
	elif beingGrabbed && loaded && loadedPumpkin != null:
		
		velocity = (origin - sling.global_position) * launchMult
		startPos = loadedPumpkin.global_position
		var gravity = loadedPumpkin.gravity
		
		var a = 0.5 * gravity.y
		var b = velocity.y
		var c = startPos.y
		var discriminant = b*b - 4*a*c
		if discriminant < 0:
			discriminant = 0
		var landingTime = (-b - sqrt(discriminant)) / (2*a)
		
		#Pumpking landing target
		var landingPos = startPos + velocity * landingTime + 0.5 * gravity * landingTime * landingTime
		
		target.global_position = landingPos
		target.visible = true
		
	else:
		target.visible = false

func update_rope(cylinder, start, end):
	var dir = end - start
	cylinder.global_position = start + dir * 0.5
	cylinder.height = dir.length()
	cylinder.look_at(end, Vector3.RIGHT)

func _on_sling_area_area_entered(area: Area3D) -> void:
	if !loaded && area.name == "PumpkinArea":
		var pumpkin = area.get_parent()
		if pumpkin.inSling == false && pumpkin.flung == false && pumpkin.onVine == false:
			pumpkin.inSling = true
			area.set_deferred("monitorable", false)
			area.set_deferred("monitoring", false)
				
			loaded = true
			loadedPumpkin = pumpkin
