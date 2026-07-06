extends Actions
class_name PeeboActions

var action_map: Dictionary

func _ready():
	action_map = {
		ActionTypes.ActionType.WANDER: $WanderAction,
		ActionTypes.ActionType.EAT: $EatAction,
		ActionTypes.ActionType.DRINK: $DrinkAction,
		ActionTypes.ActionType.REPRODUCE: $ReproduceAction,
		ActionTypes.ActionType.HUNT: $HuntAction
	}

func execute(action: ActionTypes.ActionType, peebo: Peebo) -> bool:
	var action_node: BaseAction = action_map.get(action)

	if action_node:
		return action_node.execute(peebo)

	return false
