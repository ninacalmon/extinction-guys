extends Node2D

func _ready() -> void:
	reset_game()

	TimeManager.start()


func reset_game():
	Globals.is_game_start = true

	StatsManager.reset()
	Bank.reset()
	EffectsManager.reset()

	Globals.is_game_start = false
