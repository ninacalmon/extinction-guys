extends Brain
class_name WungusBrain

func think() -> Array[ActionTypes.ActionType]:
	var priorities: Array[ActionTypes.ActionType] = []

	if creature.hunger > creature.MAX_HUNGER / 3.0 or \
	creature.thirst > creature.MAX_THIRST / 3.0:
		priorities.append(ActionTypes.ActionType.HUNT)

	if creature.can_reproduce():
		priorities.append(ActionTypes.ActionType.REPRODUCE)

	priorities.append(ActionTypes.ActionType.WANDER)

	return priorities
