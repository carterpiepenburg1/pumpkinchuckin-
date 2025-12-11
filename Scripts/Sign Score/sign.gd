extends Label3D



func _process(delta: float) -> void:
	text = "Round: %d \n Score:\n %d" % [Globals.roundNum, Globals.score]
