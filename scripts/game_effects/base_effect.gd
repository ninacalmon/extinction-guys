extends Node
class_name BaseEffect

var title: String = "Effect"
var image: CompressedTexture2D = preload("res://sprites/ui/wungus_bag.png")
var price: int = BASE_PRICE

const BASE_PRICE: int = 10

var creature_instanciator: CreatureInstanciator


func execute_effect():
	pass

func update_price():
	price *= 2
