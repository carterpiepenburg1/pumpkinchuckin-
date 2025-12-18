extends Area3D

@onready var parent = get_parent().get_parent()
@onready var pointLabel = load("res://Scenes/Objects/pointLabel.tscn")
var newPos





func _on_area_entered(area: Area3D) -> void:
	if area.name == "PumpkinArea" && visible:
		
		#Hide model
		parent.visible = false
		
		#Disable area3D
		#set_deferred("monitorable", false)
		#set_deferred("monitoring", false)
		
		#Add points and other stuff when you hit enemy
		Globals.score += 50
		
		var newPointLabel = pointLabel.instantiate()
		newPointLabel.points = 50
		get_tree().current_scene.add_child(newPointLabel)
		newPointLabel.global_position = get_parent().global_position
		newPointLabel.rotation.y = deg_to_rad(270)
		
		queue_free()
