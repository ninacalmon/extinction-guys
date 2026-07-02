extends Visuals
class_name PeeboVisuals

enum States { DEFAULT, FOCUSED }

var current_state: States = States.DEFAULT

func _ready() -> void:
	reaction_sprite.hide()

var is_focused: bool = false:
	set(value):
		if value == true:
			current_state = States.FOCUSED
		elif value == false:
			current_state = States.DEFAULT

func eat_anim(pos: Vector2i):
	sprite.flip_h = pos.x < creature.tile_pos.x

	reaction_sprite.frame = 0
	reaction_sprite.global_position = Globals.map.tile_to_world(pos)

	reaction_sprite.show()

	var tween = create_tween()
	tween.tween_property(reaction_sprite, "global_position", Globals.map.tile_to_world(creature.tile_pos), 0.6)
	animation_player.play("gather")

	await animation_player.animation_finished

	reaction_sprite.hide()

func drink_anim(pos: Vector2i):
	sprite.flip_h = pos.x < creature.tile_pos.x

	reaction_sprite.frame = 1
	reaction_sprite.global_position = Globals.map.tile_to_world(pos)

	reaction_sprite.show()

	var tween = create_tween()
	tween.tween_property(reaction_sprite, "global_position", Globals.map.tile_to_world(creature.tile_pos), 0.6)
	animation_player.play("gather")

	await animation_player.animation_finished

	reaction_sprite.hide()

func reproduce():
	reaction_sprite.frame = 2
	reaction_sprite.show()

	animation_player.play("think")

	await animation_player.animation_finished

	reaction_sprite.hide()

func die():
	pass

func set_up_sprite(sex: Peebo.SexType):
	sprite.flip_h = randi_range(0, 1)
	sprite.play("idle")

	match sex:
		Peebo.SexType.F: sprite.modulate = Color(1.0, 0.6, 0.8)
		Peebo.SexType.M: sprite.modulate = Color(0.6, 0.7, 1.0)

func _process(_delta: float) -> void:
	if current_state == States.DEFAULT:
		sprite.set_instance_shader_parameter("enabled", creature.is_hovered)
	
	elif current_state == States.FOCUSED:
		sprite.set_instance_shader_parameter("enabled", true)

func set_shader(_bool: bool):
	sprite.set_instance_shader_parameter("enabled", _bool)
