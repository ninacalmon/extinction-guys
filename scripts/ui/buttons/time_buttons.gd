extends HBoxContainer

@export var buttons_array: Array[TextureButton]


func _ready() -> void:
	for i in buttons_array:
		i.pressed.connect(_on_button_pressed.bind(i))


func _on_button_pressed(button: TextureButton):
	match button.name:
		"Slow": 
			TimeManager.alter_time(TimeManager.TurnSpeeds.SLOW)

	match button.name:
		"Pause": 
			TimeManager.alter_time(TimeManager.TurnSpeeds.PAUSED)

	match button.name:
		"Default": 
			TimeManager.alter_time(TimeManager.TurnSpeeds.DEFAULT)

	match button.name:
		"Fast": 
			TimeManager.alter_time(TimeManager.TurnSpeeds.FAST)

	match button.name:
		"SuperFast": 
			TimeManager.alter_time(TimeManager.TurnSpeeds.SUPER_FAST)


func _input(event: InputEvent) -> void:
	for button in buttons_array:
		var action: String = "time_" + button.name.to_snake_case()
		if event.is_action_pressed(action):
			button.button_pressed = true
			button.emit_signal("pressed")
			break
