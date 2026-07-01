extends BaseAction
class_name EatAction

func execute(peebo: Peebo) -> bool:
	var tile = Globals.get_tile(peebo.tile_pos)

	if tile.get("object") != "bush":
		return false

	peebo.eat()
	return true
