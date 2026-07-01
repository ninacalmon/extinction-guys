extends Node
class_name PeeboBrain

@export var peebo: Peebo


func think() -> Array[Actions.ActionType]:
	var priorities: Array[Actions.ActionType] = []

	if peebo.thirst > peebo.MAX_THIRST / 3.0:
		priorities.append(Actions.ActionType.DRINK)

	if peebo.hunger > peebo.MAX_HUNGER / 3.0:
		priorities.append(Actions.ActionType.EAT)

	if peebo.can_reproduce():
		priorities.append(Actions.ActionType.REPRODUCE)

	if randi_range(1, 2) == 1:
		priorities.append(Actions.ActionType.WANDER)

	return priorities
