extends Area3D

@onready var parent = get_parent()
@onready var timer = $"../../Timer"
		
func _on_timer_timeout() -> void:
	parent.visible = true
	
	#Enable area3D
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)

func _on_area_entered(area: Area3D) -> void:
	if area.name == "PumpkinArea" && visible:
		parent.visible = false
		
		#Disable area3D
		set_deferred("monitorable", false)
		set_deferred("monitoring", false)
		
		timer.start()
