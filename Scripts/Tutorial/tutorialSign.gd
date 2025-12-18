extends Label3D



func _process(delta: float) -> void:
	text = "Tutorial \n Score:\n %d" % [Globals.score]
