extends VBoxContainer

@onready var rich_text_label: RichTextLabel = $RichTextLabel


func _ready() -> void:
	TimeManager.turn_passed.connect(update_text)


func update_text():
	var day: String = str(StatsManager.day)

	if StatsManager.day < 10:
		day = "0%d" %StatsManager.day

	rich_text_label.text = \
"[b][pulse freq=1.0 color=#ffffff40 ease=10.0]%s[/pulse][/b]" %[day]
