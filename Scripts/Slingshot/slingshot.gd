extends Node3D

@onready var sling = $Sling
@onready var slingArea = $Sling/SlingArea

@onready var leftRope = $LeftRope
@onready var rightRope = $RightRope
@onready var leftLog = $LeftLog
@onready var rightLog = $RightLog
@onready var leftRopeSling = $Sling/leftRopeConnect
@onready var rightRopeSling = $Sling/rightRopeConnect

@onready var target = $Target
@onready var arc = $ArcPrediction

@onready var origin = sling.global_position
@onready var originRotation = sling.rotation

var loaded = false
var loadedPumpkin = null

var beingGrabbed = false

var deadzoneDistance = 0.1
var launchMult = 40

var velocity
var startPos

func _process(delta: float) -> void:
	
	#Update ropes
	var leftStart = leftLog.global_position
	leftStart.y = 1.3
	var rightStart = rightLog.global_position
	rightStart.y = 1.3
	
	updateRope(leftRope, leftStart, leftRopeSling.global_position, 0.025, 6)
	updateRope(rightRope, rightStart, rightRopeSling.global_position, 0.025, 6)
	
	#Updating pumpkins position and resetting loaded if it is no longer there
	if loaded && loadedPumpkin != null:
		loadedPumpkin.global_position = slingArea.global_position
	else:
		loaded = false
		
	#Checking if sling is being grabbed
	if !beingGrabbed:
		target.visible = false
		arc.visible = false
		
		#Return sling to normal position
		sling.global_position = lerp(sling.global_position, origin, delta*20)
		sling.rotation = originRotation
		
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
		
		#Show arc
		var arcResolution = 10   # change this

		var newCurve = Curve3D.new()
		newCurve.add_point(arc.to_local(startPos))
		for i in range(arcResolution):
			var t = (landingTime * i) / (arcResolution - 1)
			var pos = startPos + velocity * t + 0.5 * gravity * t * t
			newCurve.add_point(arc.to_local(pos))
			
		arc.curve = newCurve
		
		arc.visible = true
		
		#Update sling rotation
		var newOrigin = origin
		newOrigin.z -= 1
		var faceOrigin = newOrigin - sling.global_position
		faceOrigin.y = 0
		
		sling.rotation.y = atan2(faceOrigin.x, faceOrigin.z)
		
	else:
		target.visible = false
		arc.visible = false
		
		#Update sling rotation
		var newOrigin = origin
		newOrigin.z -= 1
		var faceOrigin = newOrigin - sling.global_position
		faceOrigin.y = 0
		
		sling.rotation.y = atan2(faceOrigin.x, faceOrigin.z)

func updateRope(rope, start, end, radius, sides):
	var mesh = CylinderMesh.new()
	mesh.top_radius = radius
	mesh.bottom_radius = radius
	mesh.height = start.distance_to(end)
	mesh.radial_segments = sides
	mesh.rings = 1

	rope.mesh = mesh

	rope.global_position = start.lerp(end, 0.5)

	rope.look_at(end, Vector3.UP)
	rope.rotate_object_local(Vector3.RIGHT, deg_to_rad(90))

func _on_sling_area_area_entered(area: Area3D) -> void:
	if !loaded && area.name == "PumpkinArea":
		var pumpkin = area.get_parent()
		if pumpkin.inSling == false && pumpkin.flung == false && pumpkin.onVine == false:
			pumpkin.inSling = true
			area.set_deferred("monitorable", false)
			area.set_deferred("monitoring", false)
				
			loaded = true
			loadedPumpkin = pumpkin
