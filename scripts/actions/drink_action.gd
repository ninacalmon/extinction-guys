extends BaseAction
class_name DrinkAction

func execute(creature: Creature) -> bool:
	var water_tiles: Array[Vector2i] = []

	for dir in Globals.DIRS:
		var pos = creature.tile_pos + dir

		if Globals.get_ground(pos) == "water":
			water_tiles.append(pos)

	if water_tiles.is_empty():
		return false

	var water_pos = water_tiles.pick_random()
	#creature.move_to(target)
	creature.drink(water_pos)
	return true
