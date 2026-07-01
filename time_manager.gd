extends Node2D

@export var turn_timer: Timer

signal turn_passed
#signal day_passed

func _ready() -> void:
	turn_timer.start()
	turn_timer.timeout.connect(on_turn_timeout)

func on_turn_timeout():
	turn_passed.emit()
	turn_timer.start()
