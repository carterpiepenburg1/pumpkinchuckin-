extends XROrigin3D

#Left Hand
@onready var leftHand = $Left
@onready var leftHandSound = $Left/LeftGrabSound

#Right Hand
@onready var rightHand = $Right
@onready var rightHandSound = $Right/RightGrabSound

func _process(delta: float) -> void:
	updateHand(leftHand, leftHandSound)
	updateHand(rightHand, rightHandSound)

func updateHand(hand, handSound):
	if hand.handGripping:
		var areas = hand.handArea.get_overlapping_areas()
		if areas.size() > 0 || hand.grabbedArea != null:
			
			if hand.grabbedArea == null:
				hand.grabbedArea = areas[0]
				handSound.play()
			
			if !hand.setOffset:
				hand.handOffset = hand.handArea.global_transform.affine_inverse() * hand.grabbedArea.global_transform
				hand.setOffset = true
					
			#When grabbing objects
			#Pumpkin
			if hand.grabbedArea.name == "PumpkinArea":
				var pumpkin = hand.grabbedArea.get_parent()
				if pumpkin.inSling == false && pumpkin.flung == false:
					pumpkin.global_transform = hand.handArea.global_transform * hand.handOffset
					pumpkin.inHand = true
					pumpkin.onVine = false
			
			#Slingshot
			if hand.grabbedArea.name == "SlingArea":
				var slingshot = hand.grabbedArea.get_parent().get_parent()
				var sling = hand.grabbedArea.get_parent()
				#needs to be fixed
				sling.global_position = hand.handArea.global_transform * hand.handOffset.origin
				slingshot.beingGrabbed = true
				
		else:
			#Reset hand gripping so you can't pick up an object without gripping its area first
			hand.handGripping = false
	else:
		hand.setOffset = false
		
		#When letting go of objects
		if hand.grabbedArea != null:
			
			#Pumpkin
			if hand.grabbedArea.name == "PumpkinArea":
				var pumpkin = hand.grabbedArea.get_parent()
				pumpkin.startPos = (hand.handArea.global_transform * hand.handOffset).origin
				pumpkin.time = 0.0
				pumpkin.inHand = false
		
			#Slingshot
			if hand.grabbedArea.name == "SlingArea":
				var slingshot = hand.grabbedArea.get_parent().get_parent()
				slingshot.beingGrabbed = false
			
			hand.grabbedArea = null

func _on_left_button_pressed(bName: String) -> void:
	if bName == "grip_click":
		leftHand.handGripping = true

func _on_left_button_released(bName: String) -> void:
	if bName == "grip_click":
		leftHand.handGripping = false

func _on_right_button_pressed(bName: String) -> void:
	if bName == "grip_click":
		rightHand.handGripping = true

func _on_right_button_released(bName: String) -> void:
	if bName == "grip_click":
		rightHand.handGripping = false
