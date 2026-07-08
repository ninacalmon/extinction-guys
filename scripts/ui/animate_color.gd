extends ColorRect

@export var colors_to_change: Array[Color]

@export var transition_time: float = 5.0

var current_index := 0
var t := 0.0

func _ready() -> void:
	if colors_to_change.is_empty():
		return

	color = colors_to_change[0]

func _process(delta: float) -> void:
	if colors_to_change.size() < 2:
		return

	t += delta / transition_time

	var next_index := (current_index + 1) % colors_to_change.size()

	color = colors_to_change[current_index].lerp(
		colors_to_change[next_index],
		t
	)

	if t >= 1.0:
		t = 0.0
		current_index = next_index
