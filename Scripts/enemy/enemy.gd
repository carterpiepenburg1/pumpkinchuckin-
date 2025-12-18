extends Area3D

@onready var root = $"../.."
@onready var pointLabel = load("res://Scenes/Objects/pointLabel.tscn")
@onready var sound = $"../Sound"
var newPos
		
func _ready() -> void:
	var gm = get_tree().current_scene.get_node("GameManager")
	gm.enemy_advance.connect(advance)
	gm.clear_enemies.connect(clearEnemies)
	
		
func _process(delta: float) -> void:
	if newPos != null:
		root.global_position = lerp(root.global_position, newPos, delta*5)
		
	
		
func advance():
	newPos = Vector3(root.global_position.x, root.global_position.y, root.global_position.z + Globals.advanceAmount)
	
func clearEnemies():
	#Do something cool
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	
	root.queue_free()

func _on_area_entered(area: Area3D) -> void:
	if area.name == "PumpkinArea" && visible:
		
		#Hide model
		root.visible = false
		
		#Disable area3D
		set_deferred("monitorable", false)
		set_deferred("monitoring", false)
		
		#Add points and other stuff when you hit enemy
		Globals.score += root.pointValue
		
		var newPointLabel = pointLabel.instantiate()
		newPointLabel.points = root.pointValue
		get_tree().current_scene.add_child(newPointLabel)
		newPointLabel.global_position = get_parent().global_position
		newPointLabel.rotation.y = deg_to_rad(270)
		
		sound.play()
		
		await sound.finished
		
		queue_free()
	
	elif area.name == "EnemyBarrier" && visible:
		
		#Hide model
		root.visible = false
		
		#Disable area3D
		set_deferred("monitorable", false)
		set_deferred("monitoring", false)
		
		queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "points":
		queue_free()
