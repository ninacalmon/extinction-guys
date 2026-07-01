extends BaseAction
class_name DrinkAction

func execute(peebo: Peebo) -> bool:
	var water_tiles: Array[Vector2i] = []

	for dir in Globals.DIRS:
		var pos = peebo.tile_pos + dir

		if Globals.get_ground(pos) == "water":
			water_tiles.append(pos)

	if water_tiles.is_empty():
		return false

	var target = water_tiles.pick_random()
	peebo.move_to(target)
	peebo.drink()
	return true
