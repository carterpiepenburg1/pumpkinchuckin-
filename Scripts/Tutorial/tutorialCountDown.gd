extends Label3D

@onready var refProgText = get_parent()
@onready var refBase = refProgText.get_parent()
@onready var refTutManager = refBase.get_node("TutorialManager")
@onready var refTimer = refTutManager.get_node("Timer2")

func _process(_delta: float) -> void:
	#text = "f" % [refTimer.time_left]
	text = str(int(refTimer.time_left))
	#text = "Hello"
