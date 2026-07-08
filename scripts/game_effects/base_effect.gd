extends Node
class_name BaseEffect

var title: String = "Effect"
var image: CompressedTexture2D = preload("res://sprites/ui/wungus_bag.png")

var price: int = BASE_PRICE:
	set(value):
		price = int(value)
		price_changed.emit(int(value))

const BASE_PRICE: int = 10

var base_price_multiply: float = 1

var creature_instanciator: CreatureInstanciator

signal price_changed(new_price: int)

func execute_effect():
	pass

func update_price():
	price *= 2
