extends Camera2D

@export var default_zoom: Vector2 = Vector2.ONE
@export var max_zoom_in: Vector2 = Vector2.ONE * 10.0
@export var def_zoom_in: Vector2 = Vector2.ONE * 5.0
@export var min_zoom_in: Vector2 = Vector2.ONE * 3.0

@export var move_speed: float = 2.0
@export var zoom_speed: float = 2.0

@export var zoom_step := 1.5

var target_zoom: Vector2
var next_zoom: Vector2
var target_pos: Vector2

var target: Creature = null

var can_zoom_in: bool = false

var initial_pos: Vector2

@export var focus_requester: FocusRequester

func _ready() -> void:
	initial_pos = global_position

	focus_requester.focus_request.connect(_on_focus_requested)

func _on_focus_requested(entity: Node2D):
	#if target:
		#return
	target = entity
	target.is_focused = true
	target_zoom = def_zoom_in
	focus_requester.targeted_entity = target

func _process(delta: float) -> void:
	if target:
		global_position = global_position.lerp(target.global_position, move_speed * delta)

	else:
		target_zoom = default_zoom
		global_position = global_position.lerp(initial_pos, move_speed * delta)

	can_zoom_in = is_instance_valid(target)
	zoom = zoom.lerp(target_zoom, zoom_speed * delta)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel_focus"):
		if is_instance_valid(target):
			EventBus.entity_hover_exited.emit(target)
			target.is_focused = false

		target = null
		focus_requester.targeted_entity = target
		target_zoom = default_zoom

	if can_zoom_in:
		if event.is_action_pressed("mouse_wheel_up"):
			var value = target_zoom.x + zoom_step
			value = clamp(value, min_zoom_in.x, max_zoom_in.x)
			target_zoom = Vector2.ONE * value

		elif event.is_action_pressed("mouse_wheel_down"):
			var value = target_zoom.x - zoom_step
			value = clamp(value, min_zoom_in.x, max_zoom_in.x)
			target_zoom = Vector2.ONE * value
