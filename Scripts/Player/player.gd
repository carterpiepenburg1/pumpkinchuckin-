extends XROrigin3D

#Left Hand
@onready var leftHand = $Left


#Right Hand
@onready var rightHand = $Right

func _process(delta: float) -> void:
	updateHand(leftHand)
	updateHand(rightHand)

func updateHand(hand):
	if hand.handGripping:
		var areas = hand.handArea.get_overlapping_areas()
		if areas.size() > 0:
			hand.grabbedArea = areas[0]
			
			if !hand.setOffset:
				hand.handOffset = hand.handArea.global_transform.affine_inverse() * hand.grabbedArea.global_transform
				hand.setOffset = true
					
			#When grabbing objects
			if hand.grabbedArea.name == "PumpkinArea":
				var pumpkin = hand.grabbedArea.get_parent()
				pumpkin.global_transform = hand.handArea.global_transform * hand.handOffset
				pumpkin.inHand = true
				pumpkin.onVine = false
				pumpkin.inSling = false
				
		else:
			hand.handGripping = false
	else:
		hand.setOffset = false
		
		#When letting go of objects
		if hand.grabbedArea != null:
			if hand.grabbedArea.name == "PumpkinArea":
				var pumpkin = hand.grabbedArea.get_parent()
				pumpkin.inHand = false
				pumpkin.onVine = false
				pumpkin.inSling = false
			
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
