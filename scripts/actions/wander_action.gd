extends BaseAction
class_name WanderAction


func execute(creature: Creature) -> bool:
	var dirs = Globals.DIRS.duplicate()
	dirs.shuffle()

	for dir in dirs:
		var next = creature.tile_pos + dir

		if Globals.is_occupied(next):
			continue

		if Globals.get_ground(next) == "" or Globals.get_ground(next) == "water":
			continue

		creature.move_to(next)
		return true

	return false
