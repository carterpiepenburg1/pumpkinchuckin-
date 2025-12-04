extends Node3D

@onready var advanceTimer = $AdvanceTimer

signal enemy_advance()

func _ready() -> void:
	advanceTimer.start()

func _on_advance_timer_timeout() -> void:
	enemy_advance.emit()
