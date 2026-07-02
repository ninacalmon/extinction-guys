extends Brain
class_name PeepoBrain

func think() -> Array[ActionTypes.ActionType]:
	var priorities: Array[ActionTypes.ActionType] = []

	if creature.thirst > creature.MAX_THIRST / 3.0:
		priorities.append(ActionTypes.ActionType.DRINK)

	if creature.hunger > creature.MAX_HUNGER / 3.0:
		priorities.append(ActionTypes.ActionType.EAT)

	if creature.can_reproduce():
		priorities.append(ActionTypes.ActionType.REPRODUCE)

	if randi_range(1, 2) == 1:
		priorities.append(ActionTypes.ActionType.WANDER)

	return priorities
