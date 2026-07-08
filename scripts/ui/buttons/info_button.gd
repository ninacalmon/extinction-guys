extends Button

@onready var rich_text_label: RichTextLabel = $RichTextLabel


func _ready() -> void:
	rich_text_label.hide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		rich_text_label.visible = !button_pressed
