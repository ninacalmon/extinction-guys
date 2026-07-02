extends Node2D
class_name FocusRequester

signal focus_request(entity: Node2D)


var targeted_entity: Peebo

func _input(event):
	if event.is_action_pressed("left_click"):
		var world_pos = get_global_mouse_position()
		var tile_pos = Globals.map.world_to_tile(world_pos)

		var entity = Globals.get_entity(tile_pos)
		if entity is Peebo:
			focus_request.emit(entity)

func _unhandled_input(event: InputEvent) -> void:
	if targeted_entity:
		if event is InputEventMouseMotion:
			var world_pos = get_global_mouse_position()
			var tile_pos = Globals.map.world_to_tile(world_pos)

			if tile_pos == targeted_entity.tile_pos:
				EventBus.entity_hover_entered.emit(targeted_entity)

			else: EventBus.entity_hover_exited.emit(targeted_entity)
