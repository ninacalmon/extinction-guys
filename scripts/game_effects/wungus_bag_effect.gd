extends BaseEffect

var amount_to_spawn: int = randi_range(10, 20)

func execute_effect():
	creature_instanciator = Globals.creature_instanciator
	print("helo")
	creature_instanciator.current_creature = creature_instanciator.wungus_scene

	for i in amount_to_spawn:
		creature_instanciator.spawn_creature()
