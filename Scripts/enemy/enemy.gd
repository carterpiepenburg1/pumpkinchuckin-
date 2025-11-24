extends Node3D

var enemy_type = 0
@onready var scarecrowModel = $Models/Scarecrow

func _ready() -> void:
	
	#Hide all models
	scarecrowModel.visible = false
	
	if enemy_type == 0:
		$AnimationPlayer.play("Scarecrow")
		scarecrowModel.visible = true
	
func _on_enemy_area_area_entered(area: Area3D) -> void:
	if area.name == "PumpkinArea" && visible:
		visible = false
		$Timer.start()
		

func _on_timer_timeout() -> void:
	visible = true
