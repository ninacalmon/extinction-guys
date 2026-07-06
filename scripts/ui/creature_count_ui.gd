extends VBoxContainer

@onready var rich_text_label: RichTextLabel = $RichTextLabel

@export_color_no_alpha var peebo_text_color: Color
@export_color_no_alpha var mimo_text_color: Color
@export_color_no_alpha var wungus_text_color: Color


func _ready() -> void:
	StatsManager.creature_amount_changed.connect(update_text)


func update_text():
	rich_text_label.text = \
"[color=%s]Peebos: [b]%d[/b][/color]
[color=%s]Mimos: [b]%d[/b][/color]
[color=%s]Wungi: [b]%d[/b][/color]" %[
peebo_text_color.to_html(),
StatsManager.peebo_amount,

mimo_text_color.to_html(),
StatsManager.mimo_amount,

wungus_text_color.to_html(),
StatsManager.wungus_amount]
