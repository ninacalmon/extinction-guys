extends Control

@export var tween_duration: float = 1.0

@export var color_rect: ColorRect
@export var text_bounds: VBoxContainer
@export var rich_text_label: RichTextLabel


func _ready() -> void:
	EventBus.lost_game.connect(_on_lost_game)

	color_rect.hide()
	text_bounds.hide()

	for i in text_bounds.get_children():
		if i is Control:
			i.hide()


func _on_lost_game(creature: String):
	TimeManager.alter_time(TimeManager.TurnSpeeds.PAUSED)

	setup_text(creature)

	chose_rect_color(creature)

	animate_and_show()


func setup_text(creature: String):
	var entity_color: Color

	match creature:
		"Peebo" : entity_color = Globals.peebo_text_color
		"Mimo" : entity_color = Globals.mimo_text_color
		"Wungus" : entity_color = Globals.wungus_text_color

	rich_text_label.text = \
	"[shake rate=20.0 level=5 connected=1][b][color=%s]%s[/color] were EXTINCT...[/b][/shake]" %[
		entity_color.to_html(), 
		creature
		]


func chose_rect_color(creature: String):
	var picked_color: Color

	match creature:
		"Peebo" : picked_color = Globals.mimo_text_color
		"Mimo" : picked_color = Globals.wungus_text_color
		"Wungus" : picked_color = Globals.peebo_text_color

	color_rect.color = picked_color


func animate_and_show():
	color_rect.position.x = get_viewport_rect().size.x * 0.5
	color_rect.size.x = 0.0
	color_rect.show()
	text_bounds.show()

	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_parallel()

	tween.tween_property(color_rect, "position:x", 0.0, tween_duration)
	tween.tween_property(color_rect, "size:x", get_viewport_rect().size.x, tween_duration)

	await tween.finished

	for i in text_bounds.get_children():
		await get_tree().create_timer(tween_duration * 0.5).timeout
		i.show()
