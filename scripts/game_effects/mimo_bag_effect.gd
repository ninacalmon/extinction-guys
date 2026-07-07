extends BaseEffect

var amount_to_spawn: int = randi_range(10, 20)

func _init():
	title = "A Bag of Mimo"
	image = preload("res://sprites/ui/mimo_bag.png")

func execute_effect():
	creature_instanciator = Globals.creature_instanciator
	creature_instanciator.current_creature = creature_instanciator.mimo_scene

	for i in amount_to_spawn:
		creature_instanciator.spawn_creature()
