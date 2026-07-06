extends BaseAction
class_name HuntAction

func execute(creature: Creature) -> bool:
	var neighboring_preys: Array = Globals.get_neighbors_of_script(creature.tile_pos, creature.creature_to_prey)

	for prey in neighboring_preys:
		if is_instance_valid(prey):
			prey.die()
			creature.prey(prey.tile_pos)
			return true

	return false
