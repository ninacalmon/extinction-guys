extends HBoxContainer

@export var buttons_array: Array[TextureButton]

func _ready() -> void:
	for i in buttons_array:
		i.pressed.connect(_on_button_pressed.bind(i))

func _on_button_pressed(button: TextureButton):
	print("pressed")
	match button.name:
		"Slow": 
			print("pressed slow")
			TimeManager.alter_time(TimeManager.TurnSpeeds.SLOW)

	match button.name:
		"Pause": 
			print("pressed pause")
			#TimeManager.alter_time(TimeManager.TurnSpeeds.SLOW)

	match button.name:
		"Default": 
			print("pressed default")
			TimeManager.alter_time(TimeManager.TurnSpeeds.DEFAULT)

	match button.name:
		"Fast": 
			print("pressed fast")
			TimeManager.alter_time(TimeManager.TurnSpeeds.FAST)

	match button.name:
		"SuperFast": 
			print("pressed super fast")
			TimeManager.alter_time(TimeManager.TurnSpeeds.SUPER_FAST)
