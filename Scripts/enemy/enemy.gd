extends Area3D

@onready var parent = get_parent().get_parent()
@onready var pointLabel = load("res://Scenes/Objects/pointLabel.tscn")
var newPos
		
func _ready() -> void:
	var gm = get_tree().current_scene.get_node("GameManager")
	gm.enemy_advance.connect(advance)
	gm.clear_enemies.connect(clearEnemies)
	
		
func _process(delta: float) -> void:
	if newPos != null:
		parent.global_position = lerp(parent.global_position, newPos, delta*20)
		
func advance():
	newPos = Vector3(parent.global_position.x, parent.global_position.y, parent.global_position.z + Globals.advanceAmount)
	
func clearEnemies():
	#Do something cool
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	
	parent.queue_free()

func _on_area_entered(area: Area3D) -> void:
	if area.name == "PumpkinArea" && visible:
		
		#Hide model
		parent.visible = false
		
		#Disable area3D
		set_deferred("monitorable", false)
		set_deferred("monitoring", false)
		
		#Add points and other stuff when you hit enemy
		Globals.score += parent.pointValue
		
		var newPointLabel = pointLabel.instantiate()
		newPointLabel.global_position = parent.global_position
		newPointLabel.points = parent.pointValue
		newPointLabel.rotation.y = deg_to_rad(270)
		get_tree().current_scene.add_child(newPointLabel)
		
		queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "points":
		queue_free()
