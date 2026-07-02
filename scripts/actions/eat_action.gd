extends BaseAction
class_name EatAction

func execute(creature: Creature) -> bool:
	var valid_bushes: Array[FruitBush] = []

	var pos: Vector2i

	for dir in Globals.DIRS:
		pos = creature.tile_pos + dir
		var entity = Globals.get_entity(pos)

		if entity is FruitBush and entity.can_collect():
			valid_bushes.append(entity)

	if valid_bushes.is_empty():
		return false

	var target_bush: FruitBush = valid_bushes.pick_random()

	target_bush.collect_fruit()

	creature.eat(target_bush.tile_pos)

	return true
