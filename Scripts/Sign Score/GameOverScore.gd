extends Label3D
var num = Globals.roundNum

func _process(_delta: float) -> void:
	if Globals.roundNum == 5:
		visible = true
	else:
		visible = false
