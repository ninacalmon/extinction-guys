extends Creature
class_name Mimo

var child_count: int = 0
const MAX_CHILDREN: int = 2

func _ready() -> void:
	my_name = Globals.names.pick_random()

	TimeManager.half_turn_passed.connect(_on_turn)

var is_focused: bool = false:
	set(value):
		visuals.is_focused = value


func eat(pos: Vector2i):
	visuals.eat_anim(pos)
	#tween.tween_property(sprite, "self_modulate", Color.RED, 0.5)
	hunger = 0


func drink(pos: Vector2i):
	visuals.drink_anim(pos)
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
	return child_count < MAX_CHILDREN and \
	age > MAX_AGE * 0.1

func can_reproduce_with(other: Mimo) -> bool:
	if !can_reproduce():
		return false

	if !other.can_reproduce():
		return false
	
	# more rules...

	return true

func reproduce(partner: Mimo):
	child_count += 1

	visuals.reproduce()

	partner.visuals.reproduce()

	var offset: Vector2i = Globals.get_valid_directions(tile_pos).pick_random()
	Globals.mimo_instanciator.create_new_mimo(tile_pos + offset)
	had_child = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_world_pos = get_global_mouse_position()
		var mouse_tile_pos = Globals.map.world_to_tile(mouse_world_pos)
		is_hovered = tile_pos == mouse_tile_pos
