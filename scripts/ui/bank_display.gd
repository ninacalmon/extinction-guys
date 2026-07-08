extends Control

@onready var rich_text_label: RichTextLabel = $VBoxContainer/RichTextLabel

func _ready() -> void:
	Bank.money_changed.connect(_on_money_changed)

	rich_text_label.text = "[wave amp=12 freq=4][b]%d[/b][/wave] [img align=bottom]res://sprites/ui/lf_icon.png[/img]Lƒ" %Bank.balance


func _on_money_changed(new_amount: int):
	rich_text_label.text = \
	"[wave amp=12 freq=4][b]%d[/b][/wave] [img align=bottom]res://sprites/ui/lf_icon.png[/img]Lƒ" %new_amount
