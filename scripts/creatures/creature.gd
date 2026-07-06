extends Node2D
class_name Creature

var tile_pos: Vector2i

@export var MAX_AGE: int = 100
@export var MAX_HUNGER: int = 60
@export var MAX_THIRST: int = 40

var age: int = 0
var hunger: int = 0
var thirst: int = 0

enum SexType {F, M}
var sex: SexType

var had_child: bool = false

var my_name: String

var is_hovered: bool = false

@export var brain: Brain 
@export var visuals: Visuals 
@export var actions: Actions 
@export var sprite: AnimatedSprite2D 

@export var creature_to_prey: Script


func _on_turn():
	update_stats()

	if is_overpopulated():
		die()
		return

	if should_die():
		die()
		return

	for action in brain.think():
		if actions.execute(action, self):
			return


func update_stats():
	age += 1
	hunger += 1
	thirst += 1

func is_overpopulated() -> bool:
	return Globals.get_neighbors_of_script(tile_pos, Creature).size() >= 3


func should_die() -> bool:
	print("VOU MORRER DE IDADE?  ", age >= MAX_AGE)
	return age >= MAX_AGE or hunger >= MAX_HUNGER or thirst >= MAX_THIRST


func die():
	Globals.remove_entity(tile_pos)
	await visuals.die()
	queue_free()
