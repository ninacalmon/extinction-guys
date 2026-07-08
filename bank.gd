extends Node

signal money_changed(new_amount: int)

var balance: int = 0

var base_value: int = 1

var action_values: Dictionary = {
	ActionTypes.ActionType.WANDER : base_value,
	ActionTypes.ActionType.EAT : base_value * 2,
	ActionTypes.ActionType.DRINK : base_value * 2,
	ActionTypes.ActionType.HUNT : base_value * 5,
	ActionTypes.ActionType.REPRODUCE : base_value * 5,
}

func deposit(amount: int) -> void:
	if amount <= 0:
		return

	balance += amount
	money_changed.emit(balance)


func can_afford(amount: int) -> bool:
	return balance >= amount


func buy(cost: int) -> bool:
	if not can_afford(cost):
		return false

	balance -= cost

	money_changed.emit(balance)
	return true


func get_balance() -> int:
	return balance


func set_balance(amount: int) -> void:
	balance = max(amount, 0)
	money_changed.emit(balance)


func reset() -> void:
	balance = 0
	money_changed.emit(balance)
