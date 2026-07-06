extends Creature
class_name Peebo

func _ready() -> void:
	my_name = Globals.names.pick_random()

	sex = [SexType.F, SexType.M].pick_random()
	visuals.set_up_sprite(sex)

	TimeManager.turn_passed.connect(_on_turn)


var is_focused: bool = false:
	set(value):
		visuals.is_focused = value


func eat(pos: Vector2i):
	visuals.eat_anim(pos)
	hunger = floor(hunger * 0.3)


func drink(pos: Vector2i):
	visuals.drink_anim(pos)
	thirst = floor(thirst * 0.3)

func prey(pos: Vector2i):
	visuals.prey(pos)
	had_child = false
	hunger = 0
	thirst = 0

func move_to(next: Vector2i):
	var old_pos = tile_pos

	sprite.flip_h = next.x < old_pos.x

	Globals.remove_entity(old_pos)
	tile_pos = next
	Globals.add_entity(tile_pos, self)

	var target = Globals.map.tile_to_world(tile_pos)

	sprite.play("walk")
	var tween = create_tween()
	tween.tween_property(self, "global_position", target, 0.5)
	await tween.finished
	sprite.play("idle")


func can_reproduce() -> bool:
	return age >= MAX_AGE / 10.0 and !had_child

func can_reproduce_with(other: Peebo) -> bool:
	if !can_reproduce():
		return false

	if !other.can_reproduce():
		return false

	if sex == other.sex:
		return false
	
	# more rules...

	return true

func reproduce(partner: Peebo):
	visuals.reproduce()

	partner.visuals.reproduce()

	Globals.peebo_instanciator.create_new_egg(tile_pos + Vector2i(0, 1))
	had_child = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_world_pos = get_global_mouse_position()
		var mouse_tile_pos = Globals.map.world_to_tile(mouse_world_pos)
		is_hovered = tile_pos == mouse_tile_pos
