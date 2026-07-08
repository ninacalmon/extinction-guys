extends BaseEffect

var amount_to_spawn: int

func _init():
	title = "A Bag of Mimo"
	image = preload("res://sprites/ui/mimo_bag.png")
	base_price_multiply = 10.0
	price = int(BASE_PRICE * base_price_multiply)

func execute_effect():
	amount_to_spawn = randi_range(10, 20)

	creature_instanciator = Globals.creature_instanciator
	creature_instanciator.current_creature = creature_instanciator.mimo_scene

	for i in amount_to_spawn:
		creature_instanciator.spawn_creature()

	EventBus.bag_effect_used.emit("Mimo", amount_to_spawn)
