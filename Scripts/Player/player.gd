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
			var grabbedArea = areas[0]
			
			if !hand.setOffset:
					hand.handOffset = hand.handArea.global_transform.affine_inverse() * grabbedArea.global_transform
					hand.setOffset = true
					
			#Grabbed object logic
			if grabbedArea.name == "PumpkinArea":
				var pumpkin = grabbedArea.get_parent()
				pumpkin.global_transform = hand.handArea.global_transform * hand.handOffset
				
		else:
			hand.handGripping = false
	else:
		hand.setOffset = false

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
