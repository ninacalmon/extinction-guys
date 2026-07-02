extends Actions
class_name MimoActions

var action_map: Dictionary

func _ready():
	action_map = {
		ActionTypes.ActionType.WANDER: $WanderAction,
		ActionTypes.ActionType.EAT: $EatAction,
		ActionTypes.ActionType.DRINK: $DrinkAction,
		ActionTypes.ActionType.REPRODUCE: $ReproduceAction,
	}

func execute(action: ActionTypes.ActionType, mimo: Mimo) -> bool:
	var action_node: BaseAction = action_map.get(action)

	if action_node:
		return action_node.execute(mimo)

	return false
