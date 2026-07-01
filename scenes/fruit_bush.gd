extends Node2D
class_name FruitBush

@onready var sprite_2d: Sprite2D = $Sprite2D

var fruits: int = 3:
	set(value):
		fruits = clampi(value, 0, 3)

const TURNS_TO_REGROW: int = 5
var turns_passed: int = 0


func _ready() -> void:
	TimeManager.turn_passed.connect(_on_turn)

	update_sprite()


func _on_turn():
	turns_passed += 1

	if turns_passed >= TURNS_TO_REGROW:
		turns_passed = 0
		regrow_fruit()


func regrow_fruit():
	if fruits < 3:
		fruits += 1
		update_sprite()


func update_sprite():
	match fruits:
		0: sprite_2d.frame = 3
		1: sprite_2d.frame = 2
		2: sprite_2d.frame = 1
		3: sprite_2d.frame = 0


func can_collect() -> bool:
	return fruits > 0


func collect_fruit():
	fruits -= 1
	update_sprite()
