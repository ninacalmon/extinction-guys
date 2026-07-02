extends Node2D

@export var turn_timer: Timer
@export var half_turn_timer: Timer
@export var double_turn_timer: Timer

signal turn_passed
signal half_turn_passed
signal double_turn_passed
#signal day_passed

func _ready() -> void:
	turn_timer.start()
	half_turn_timer.start()
	double_turn_timer.start()

	turn_timer.timeout.connect(on_turn_timeout)
	half_turn_timer.timeout.connect(on_half_turn_timeout)
	double_turn_timer.timeout.connect(on_double_turn_timeout)


func on_turn_timeout():
	turn_passed.emit()
	turn_timer.start()


func on_half_turn_timeout():
	half_turn_passed.emit()
	half_turn_timer.start()


func on_double_turn_timeout():
	double_turn_passed.emit()
	double_turn_timer.start()
