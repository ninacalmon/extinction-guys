extends Node2D
class_name Creature

var tile_pos: Vector2i

var age: int = 0
var hunger: int = 10
var thirst: int = 5

const MAX_AGE: int = 100
const MAX_HUNGER: int = 60
const MAX_THIRST: int = 40

enum SexType {F, M}
var sex: SexType

var had_child: bool = false

var my_name: String

var is_hovered: bool = false

@export var brain: Brain 
@export var visuals: Visuals 
@export var actions: Actions 
@export var sprite: AnimatedSprite2D 

func _ready() -> void:
	my_name = Globals.names.pick_random()

	sex = [SexType.F, SexType.M].pick_random()
	visuals.set_up_sprite(sex)

	TimeManager.turn_passed.connect(_on_turn)


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
	return Globals.get_neighbors_of_script(tile_pos, Creature).size() >= 4


func should_die() -> bool:
	return age >= MAX_AGE or hunger >= MAX_HUNGER or thirst >= MAX_THIRST


func die():
	TimeManager.turn_passed.disconnect(_on_turn)
	Globals.remove_entity(tile_pos)
	await visuals.die()
	queue_free()
