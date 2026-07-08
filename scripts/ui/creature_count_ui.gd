extends VBoxContainer

@onready var rich_text_label: RichTextLabel = $RichTextLabel

func _ready() -> void:
	StatsManager.creature_amount_changed.connect(update_text)

func update_text():
	rich_text_label.text = \
"[color=%s]Peebos: [b]%d[/b][/color]
[color=%s]Mimos: [b]%d[/b][/color]
[color=%s]Wungi: [b]%d[/b][/color]" %[
Globals.peebo_text_color.to_html(),
StatsManager.peebo_amount,

Globals.mimo_text_color.to_html(),
StatsManager.mimo_amount,

Globals.wungus_text_color.to_html(),
StatsManager.wungus_amount]
