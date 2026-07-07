extends VBoxContainer

@onready var rich_text_label: RichTextLabel = $RichTextLabel


func _ready() -> void:
	TimeManager.turn_passed.connect(update_text)


func update_text():
	var day: String = str(StatsManager.day)

	if StatsManager.day < 10:
		day = "0%d" %StatsManager.day

	animate_pulse()
	rich_text_label.text = "[b]%s[/b]" %[day]

func animate_pulse():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(rich_text_label, "modulate", Color.WHITE, TimeManager.current_turn_speed * 0.5)\
	.from(Color(0.2, 0.129, 0.149, 1.0))
