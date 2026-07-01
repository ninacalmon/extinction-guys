extends Node2D
class_name MapGen

@export var main_noise_texture: NoiseTexture2D
@export var bush_noise_texture: NoiseTexture2D

var width: int
var height: int

var main_noise: Noise
var bush_noise: Noise

@onready var tile_map_layer_ground: TileMapLayer = $TileMapLayerGround
@onready var tile_map_layer_above: TileMapLayer = $TileMapLayerAbove

var source_id := 0

var grass_atlas: Array[Vector2i] = [Vector2i(0, 0)]
var sand_atlas: Array[Vector2i] = [Vector2i(1, 0)]
var water_atlas: Array[Vector2i] = [Vector2i(2, 0)]
var bush_atlas: Array[Vector2i] = [Vector2i(0, 1)]

func _ready() -> void:
	Globals.map = self

	width = Globals.world_width
	height = Globals.world_height

	#global_position = get_viewport().get_center()

	main_noise = main_noise_texture.noise
	bush_noise = bush_noise_texture.noise
	generate_world()

func generate_world() -> void:
	for x in range(-width * 0.5, width * 0.5):
		for y in range(-height * 0.5, height * 0.5):

			var pos := Vector2i(x, y)

			var terrain := main_noise.get_noise_2d(x, y)

			if terrain < -0.25:
				Globals.set_tile(pos, "water")
				tile_map_layer_ground.set_cell(pos, source_id, water_atlas.pick_random())

			elif terrain < -0.05:
				Globals.set_tile(pos, "sand")
				tile_map_layer_ground.set_cell(pos, source_id, sand_atlas.pick_random())

			else:
				var object := ""

				var bush := bush_noise.get_noise_2d(x, y)
				if bush > 0.35:
					object = "bush"
					tile_map_layer_above.set_cell(
						pos,
						source_id,
						bush_atlas.pick_random()
					)

				Globals.set_tile(pos, "grass", object)

				tile_map_layer_ground.set_cell(
					pos,
					source_id,
					grass_atlas.pick_random()
				)

func tile_to_world(tile: Vector2i) -> Vector2:
	return tile_map_layer_ground.map_to_local(tile)

func world_to_tile(pos: Vector2) -> Vector2i:
	return tile_map_layer_ground.local_to_map(pos)
