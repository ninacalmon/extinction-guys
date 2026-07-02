extends BaseAction
class_name ReproduceAction

func execute(creature: Creature) -> bool:
	var neighbors = Globals.get_neighbors_of_script(creature.tile_pos, creature.get_script())

	for partner in neighbors:
		if creature.can_reproduce_with(partner):
			creature.reproduce(partner)
			return true

	return false
