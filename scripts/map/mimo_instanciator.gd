extends Node2D
class_name MimoInstanciator

@export var mimo_start_amount: int = 20
@export var mimo_scene: PackedScene

func _ready() -> void:
	Globals.mimo_instanciator = self

	for i in mimo_start_amount:
		spawn_mimo()

func spawn_mimo():
	var new_mimo: Mimo = mimo_scene.instantiate()

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

		new_mimo.global_position = Globals.map.tile_to_world(pos)
		new_mimo.tile_pos = pos

		Globals.add_entity(pos, new_mimo)

		break

	add_child(new_mimo)

func create_new_mimo(pos: Vector2i):
	var new_mimo: Mimo = mimo_scene.instantiate()

	new_mimo.tile_pos = pos
	new_mimo.global_position = Globals.map.tile_to_world(pos)

	Globals.add_entity(pos, new_mimo)

	add_child(new_mimo)
