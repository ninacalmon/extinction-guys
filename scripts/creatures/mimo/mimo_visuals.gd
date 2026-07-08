extends Visuals
class_name MimoVisuals

enum States { DEFAULT, FOCUSED }

var current_state: States = States.DEFAULT

#func _ready() -> void:
	#reaction_sprite.hide()

var is_focused: bool = false:
	set(value):
		if value == true:
			current_state = States.FOCUSED
		elif value == false:
			current_state = States.DEFAULT

func eat_anim(_pos: Vector2i):
	pass

func drink_anim(_pos: Vector2i):
	pass

func reproduce():
	reaction_sprite.frame = 2
	reaction_sprite.show()

	animation_player.play("think")

	await animation_player.animation_finished

	reaction_sprite.hide()


func set_up_sprite(_sex: Peebo.SexType):
	sprite.flip_h = randi_range(0, 1)
	sprite.play("idle")


func _process(_delta: float) -> void:
	if current_state == States.DEFAULT:
		sprite.set_instance_shader_parameter("enabled", creature.is_hovered)
	
	elif current_state == States.FOCUSED:
		sprite.set_instance_shader_parameter("enabled", true)

func set_shader(_bool: bool):
	sprite.set_instance_shader_parameter("enabled", _bool)
