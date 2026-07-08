extends Control
class_name EffectPopUp

@export var duration: float = 2.0

@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var rich_text_label_outline: RichTextLabel = $RichTextLabelOutline

var _tween: Tween


func show_pop_up(entity: String, amount: int):
	setup_text(entity, amount)

	global_position = choose_random_spot()

	show_up()

	await get_tree().create_timer(duration).timeout

	hide_down()

func setup_text(entity: String, amount: int):
	var entity_color: Color

	match entity:
		"Peebo" : entity_color = Globals.peebo_text_color
		"Mimo" : entity_color = Globals.mimo_text_color
		"Wungus" : entity_color = Globals.wungus_text_color

	rich_text_label.text = "[color=%s][wave amp=12 freq=4][b]+%d[/b] %s[/wave][/color]" %[
		entity_color.to_html(),
		amount,
		entity.to_upper()
	]

	rich_text_label_outline.text = rich_text_label.text

func choose_random_spot() -> Vector2:
	var _size = get_viewport().get_visible_rect().size

	return Vector2(
		clampf(randfn(_size.x * 0.5, _size.x * 0.2), 0.0, _size.x),
		clampf(randfn(_size.y * 0.5, _size.y * 0.2), 0.0, _size.y)
	)

func show_up() -> void:
	if _tween:
		_tween.kill()

	visible = true
	modulate.a = 0.0
	scale = Vector2(0.9, 0.9)
	position.y += 12

	_tween = create_tween()
	_tween.set_parallel(true)

	_tween.tween_property(self, "position:y", position.y - 12, 0.18)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)

	_tween.tween_property(self, "scale", Vector2.ONE, 0.18)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)

	_tween.tween_property(self, "modulate:a", 1.0, 0.12)


func hide_down() -> void:
	if _tween:
		_tween.kill()

	_tween = create_tween()
	_tween.set_parallel(true)

	_tween.tween_property(self, "position:y", position.y + 10, 0.14)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_IN)

	_tween.tween_property(self, "scale", Vector2(0.92, 0.92), 0.14)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_IN)

	_tween.tween_property(self, "modulate:a", 0.0, 0.12)

	await _tween.finished

	queue_free()
