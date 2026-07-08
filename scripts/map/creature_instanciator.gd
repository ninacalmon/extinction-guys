extends Node2D
class_name CreatureInstanciator

@export_range(0, 1000, 1, "prefer_slider") var peebo_start_amount: int = 40
@export_range(0, 1024, 1, "prefer_slider") var mimo_start_amount: int = 80
@export_range(0, 1024, 1, "prefer_slider") var wungus_start_amount: int = 0

@export var peebo_scene: PackedScene
@export var mimo_scene: PackedScene
@export var wungus_scene: PackedScene
@export var egg_scene: PackedScene

var current_creature: PackedScene

func _ready() -> void:
	Globals.creature_instanciator = self

	spawn_initial_batch()


func spawn_initial_batch():
	current_creature = peebo_scene
	
	for i in peebo_start_amount:
		spawn_creature()

	current_creature = mimo_scene
	
	for i in mimo_start_amount:
		spawn_creature()

	current_creature = wungus_scene
	
	for i in wungus_start_amount:
		spawn_creature()



func spawn_creature():
	var new_creature: Creature = current_creature.instantiate()

	var tries: int = 0
	var max_tries: int = 200

	while tries < max_tries:
		tries += 1

		#var pos := Vector2i(-Globals.world_width * 0.5, -Globals.world_height * 0.5)
		var pos := Vector2i(
			randi_range(-Globals.world_width * 0.5, Globals.world_width * 0.5 - 1),
			randi_range(-Globals.world_height * 0.5, Globals.world_height * 0.5 - 1)
		)


		if Globals.get_tile(pos).is_empty():
			continue

		if Globals.get_ground(pos) == "water":
			continue

		if Globals.is_occupied(pos):
			continue

		new_creature.global_position = Globals.map.tile_to_world(pos)
		new_creature.tile_pos = pos

		Globals.add_entity(pos, new_creature)

		break

	new_creature.age = randi_range(0, floor(new_creature.MAX_AGE/4.0))
	new_creature.hunger = randi_range(0, floor(new_creature.MAX_HUNGER/4.0))
	new_creature.thirst = randi_range(0, floor(new_creature.MAX_THIRST/4.0))

	add_child(new_creature)


func create_new_creature(pos: Vector2i):
	var new_creature: Creature = current_creature.instantiate()

	new_creature.tile_pos = pos
	new_creature.global_position = Globals.map.tile_to_world(pos)

	Globals.add_entity(pos, new_creature)

	add_child(new_creature)


func create_new_egg(pos: Vector2i):
	var new_egg: PeeboEgg = egg_scene.instantiate()

	new_egg.tile_pos = pos
	new_egg.global_position = Globals.map.tile_to_world(pos)

	Globals.add_entity(pos, new_egg)

	add_child(new_egg)
