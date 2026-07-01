extends BaseAction
class_name ReproduceAction

func execute(peebo: Peebo) -> bool:
	var neighbors = Globals.get_neighbors_of_script(peebo.tile_pos, Peebo)

	for partner in neighbors:
		if peebo.can_reproduce_with(partner):
			Globals.peebo_instanciator.create_new_egg(peebo.tile_pos + Vector2i(0, 1))
			peebo.had_child = true
			return true

	return false
