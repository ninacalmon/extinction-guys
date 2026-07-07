extends Node2D
class_name Fence

@onready var sprite_2d: Sprite2D = $Sprite2D

var tile_pos: Vector2i

func _ready() -> void:
	adjust_sprite()

func adjust_sprite() -> void:
	var left = -Globals.world_width / 2 - 1
	var right = Globals.world_width / 2
	var top = -Globals.world_height / 2 - 1
	var bottom = Globals.world_height / 2

	if tile_pos == Vector2i(left, top):
		# top-left corner
		sprite_2d.frame = 0

	elif tile_pos == Vector2i(right, top):
		# top-right corner
		sprite_2d.frame = 2

	elif tile_pos == Vector2i(left, bottom):
		# bottom-left corner
		sprite_2d.frame = 6

	elif tile_pos == Vector2i(right, bottom):
		# bottom-right corner
		sprite_2d.frame = 8

	elif tile_pos.y == top:
		# top edge
		sprite_2d.frame = 1

	elif tile_pos.y == bottom:
		# bottom edge
		sprite_2d.frame = 7

	elif tile_pos.x == left:
		# left edge
		sprite_2d.frame = 3

	elif tile_pos.x == right:
		# right edge
		sprite_2d.frame = 5
