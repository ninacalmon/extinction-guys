extends Node2D
class_name PeeboInstanciator

@export var peebo_start_amount: int = 20
@export var peebo_scene: PackedScene
@export var egg_scene: PackedScene

func _ready() -> void:
	Globals.peebo_instanciator = self

	for i in peebo_start_amount:
		spawn_peebo()

func spawn_peebo():
	var new_peebo: Peebo = peebo_scene.instantiate()

	var tries := 0
	var max_tries := 100

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

		new_peebo.global_position = Globals.map.tile_to_world(pos)
		new_peebo.tile_pos = pos

		Globals.add_entity(pos, new_peebo)

		break

	add_child(new_peebo)

func create_new_peebo(pos: Vector2i):
	var new_peebo: Peebo = peebo_scene.instantiate()

	new_peebo.tile_pos = pos
	new_peebo.global_position = Globals.map.tile_to_world(pos)

	Globals.add_entity(pos, new_peebo)

	add_child(new_peebo)

func create_new_egg(pos: Vector2i):
	var new_egg: PeeboEgg = egg_scene.instantiate()

	new_egg.tile_pos = pos
	new_egg.global_position = Globals.map.tile_to_world(pos)

	Globals.add_entity(pos, new_egg)

	add_child(new_egg)
