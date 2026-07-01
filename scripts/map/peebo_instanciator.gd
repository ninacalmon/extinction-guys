extends Node2D
class_name PeeboInstanciator

@export var peebo_start_amount: int = 20
@export var peebo_scene: PackedScene

func _ready() -> void:
	Globals.peebo_instanciator = self

	for i in peebo_start_amount:
		spawn_peebo()

func spawn_peebo():
	var new_peebo: Peebo = peebo_scene.instantiate()

	while true:
		var pos := Vector2i(
			randi_range(-Globals.world_width * 0.5, Globals.world_width * 0.5 - 1),
			randi_range(-Globals.world_height * 0.5, Globals.world_height * 0.5 - 1)
		)

		if Globals.get_ground(pos) == "":
			continue

		if Globals.get_ground(pos) == "water":
			continue

		if Globals.is_occupied(pos):
			continue

		new_peebo.tile_pos = pos

		Globals.add_entity(pos, new_peebo)

		add_child(new_peebo)

		new_peebo.global_position = Globals.map.tile_to_world(pos)

		print("Spawned peebo at: ", pos)
		break

func create_new_peebo(pos: Vector2i):
	var new_peebo: Peebo = peebo_scene.instantiate()

	if Globals.get_ground(pos) == "water":
		return

	if Globals.is_occupied(pos):
		return

	new_peebo.tile_pos = pos

	add_child(new_peebo)

	Globals.add_entity(pos, new_peebo)

	new_peebo.global_position = Globals.map.tile_to_world(pos)
