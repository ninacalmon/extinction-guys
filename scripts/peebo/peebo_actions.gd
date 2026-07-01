extends Node
class_name PeeboActions

var action_map: Dictionary

func _ready():
	action_map = {
		Actions.ActionType.WANDER: $WanderAction,
		Actions.ActionType.EAT: $EatAction,
		Actions.ActionType.DRINK: $DrinkAction,
		Actions.ActionType.REPRODUCE: $ReproduceAction,
	}

func execute(action: Actions.ActionType, peebo: Peebo) -> bool:
	var action_node: BaseAction = action_map.get(action)

	if action_node:
		return action_node.execute(peebo)

	return false
