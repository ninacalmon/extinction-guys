extends Node2D

@export var turn_timer: Timer
@export var half_turn_timer: Timer
@export var double_turn_timer: Timer

signal turn_passed
signal half_turn_passed
signal double_turn_passed
#signal day_passed

var original_turn_wait_time: float

var current_turn_speed: float

enum TurnSpeeds {DEFAULT, SLOW, FAST, SUPER_FAST}

func _ready() -> void:
	original_turn_wait_time = turn_timer.wait_time
	current_turn_speed = turn_timer.wait_time

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

func alter_time(new_speed: TurnSpeeds):
	match new_speed:
		TurnSpeeds.DEFAULT:
			var new_speed_wait_time: float = original_turn_wait_time
			current_turn_speed = new_speed_wait_time
			turn_timer.wait_time = new_speed_wait_time
			half_turn_timer.wait_time = new_speed_wait_time * 0.5
			double_turn_timer.wait_time = new_speed_wait_time * 2.0

		TurnSpeeds.SLOW:
			var new_speed_wait_time: float = original_turn_wait_time * 5
			current_turn_speed = new_speed_wait_time
			turn_timer.wait_time = new_speed_wait_time
			half_turn_timer.wait_time = new_speed_wait_time * 0.5
			double_turn_timer.wait_time = new_speed_wait_time * 2.0

		TurnSpeeds.FAST:
			var new_speed_wait_time: float = original_turn_wait_time * 0.5
			current_turn_speed = new_speed_wait_time
			turn_timer.wait_time = new_speed_wait_time
			half_turn_timer.wait_time = new_speed_wait_time * 0.5
			double_turn_timer.wait_time = new_speed_wait_time * 2.0

		TurnSpeeds.SUPER_FAST:
			var new_speed_wait_time: float = original_turn_wait_time * 0.12
			current_turn_speed = new_speed_wait_time
			turn_timer.wait_time = new_speed_wait_time
			half_turn_timer.wait_time = new_speed_wait_time * 0.5
			double_turn_timer.wait_time = new_speed_wait_time * 2.0
