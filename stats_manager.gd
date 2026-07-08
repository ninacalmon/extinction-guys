extends Node

signal creature_amount_changed

var day: int

var peebo_amount: int = 0:
	set(value):
		peebo_amount = value
		creature_amount_changed.emit()
		if value <= 0:
			EventBus.lost_game.emit("Peebo")

var mimo_amount: int = 0:
	set(value):
		mimo_amount = value
		creature_amount_changed.emit()
		if value <= 0:
			EventBus.lost_game.emit("Mimo")

var wungus_amount: int = 0:
	set(value):
		wungus_amount = value
		creature_amount_changed.emit()
		if value <= 0:
			EventBus.lost_game.emit("Wungus")

var creature_counter: CreatureCounter = preload("res://scripts/creature_counter.gd").new()

func _ready() -> void:
	EventBus.died.connect(creature_counter._on_creature_died)
	EventBus.born.connect(creature_counter._on_creature_born)

	#EventBus.lost_game.connect(lost_game)

	TimeManager.turn_passed.connect(func(): day += 1)


#func lost_game(creature: String):
	#pass
