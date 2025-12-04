extends Area3D

@onready var parent = get_parent()
@onready var timer = $"../../Timer"
var newPos
		
func _ready() -> void:
	get_tree().current_scene.get_node("GameManager").enemy_advance.connect(advance)
		
func _process(delta: float) -> void:
	if newPos != null:
		parent.global_position = lerp(global_position, newPos, delta*20)
		
func advance():
	newPos = Vector3(global_position.x, global_position.y, global_position.z + Globals.advanceAmount)
	
		
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
		
