extends Node2D
class_name Peebo

var tile_pos: Vector2i

var age: int = 0
var hunger: int = 10
var thirst: int = 5

const MAX_AGE: int = 100
const MAX_HUNGER: int = 60
const MAX_THIRST: int = 40

enum SexType {F, M}
var sex: SexType

var had_child: bool = false

@onready var brain: PeeboBrain = $PeeboBrain
@onready var actions: PeeboActions = $PeeboActions
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	sex = [SexType.F, SexType.M].pick_random()
	set_up_sprite()

	TimeManager.turn_passed.connect(_on_turn)


func _on_turn():
	sprite.self_modulate = Color.WHITE
	update_stats()

	if is_overpopulated():
		die("overpopulation")
		return

	if should_die():
		var text = str(age, hunger, thirst)
		die("morte morrida. STATS: age: %d, hunger: %d, thirst: %d" %[age, hunger, thirst])
		return

	for action in brain.think():
		if actions.execute(action, self):
			return


func update_stats():
	age += 1
	hunger += 1
	thirst += 1


func should_die() -> bool:
	return age >= MAX_AGE or hunger >= MAX_HUNGER or thirst >= MAX_THIRST


func is_overpopulated() -> bool:
	return Globals.get_neighbors_of_script(tile_pos, Peebo).size() >= 4


func die(reason: String):
	print("DIED OF : ", reason)
	TimeManager.turn_passed.disconnect(_on_turn)
	Globals.remove_entity(tile_pos)
	var tween = create_tween()
	tween.tween_property(sprite, "self_modulate", Color.BLACK, 0.5)
	await tween.finished
	queue_free()

func eat():
	var tween = create_tween()
	tween.tween_property(sprite, "self_modulate", Color.RED, 0.5)
	hunger = 0


func drink():
	var tween = create_tween()
	tween.tween_property(sprite, "self_modulate", Color.BLUE, 0.5)
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

func set_up_sprite():
	sprite.flip_h = randi_range(0, 1)
	sprite.play("idle")

	match sex:
		SexType.F: sprite.modulate = Color(1.0, 0.6, 0.8)
		SexType.M: sprite.modulate = Color(0.6, 0.7, 1.0)
