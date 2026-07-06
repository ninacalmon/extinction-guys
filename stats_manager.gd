extends Node

signal creature_amount_changed

var day: int

var peebo_amount: int = 0:
	set(value):
		peebo_amount = value
		creature_amount_changed.emit()

var mimo_amount: int = 0:
	set(value):
		mimo_amount = value
		creature_amount_changed.emit()

var wungus_amount: int = 0:
	set(value):
		wungus_amount = value
		creature_amount_changed.emit()

var creature_counter: CreatureCounter = preload("res://scripts/creature_counter.gd").new()

func _ready() -> void:
	EventBus.died.connect(creature_counter._on_creature_died)
	EventBus.born.connect(creature_counter._on_creature_born)

	TimeManager.turn_passed.connect(func(): day += 1)
