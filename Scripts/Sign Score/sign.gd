extends Label3D



func _process(delta: float) -> void:
	if Globals.roundNum < 4:
		text = "Round: %d \n Score:\n %d" % [Globals.roundNum, Globals.score]
	elif Globals.roundNum == 4:
		text = "Bonus Round \n Score:\n %d" % [Globals.score]
	else:
		text = "Final Score:\n %d" % [Globals.score]
	
	
