extends BaseAction
class_name EatAction

func execute(peebo: Peebo) -> bool:
	var valid_bushes: Array[FruitBush] = []

	for dir in Globals.DIRS:
		var pos = peebo.tile_pos + dir
		var entity = Globals.get_entity(pos)

		if entity is FruitBush and entity.can_collect():
			valid_bushes.append(entity)

	if valid_bushes.is_empty():
		return false

	var target_bush: FruitBush = valid_bushes.pick_random()

	target_bush.collect_fruit()
	peebo.eat()

	return true
