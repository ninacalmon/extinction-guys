extends Actions
class_name WungusActions

var action_map: Dictionary

func _ready():
	action_map = {
		ActionTypes.ActionType.WANDER: $WanderAction,
		ActionTypes.ActionType.REPRODUCE: $ReproduceAction,
		ActionTypes.ActionType.HUNT: $HuntAction
	}

func execute(action: ActionTypes.ActionType, wungus: Wungus) -> bool:
	var action_node: BaseAction = action_map.get(action)

	if action_node:
		return action_node.execute(wungus)

	return false
