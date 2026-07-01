extends Node2D
class_name Peebo

var tile_pos: Vector2i

var age: int = 0
var hunger: int = 10
var thirst: int = 5

const MAX_AGE: int = 100
const MAX_HUNGER: int = 40
const MAX_THIRST: int = 25

@onready var brain: PeeboBrain = $PeeboBrain
@onready var actions: PeeboActions = $PeeboActions
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D



func _ready() -> void:
	sprite.flip_h = randi_range(0, 1)
	sprite.play("idle")

	TimeManager.turn_passed.connect(_on_turn)


func _on_turn():
	update_stats()

	if is_overpopulated():
		die()
		return

	if should_die():
		die()
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


func die():
	TimeManager.turn_passed.disconnect(_on_turn)
	Globals.remove_entity(tile_pos)
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color.BLACK, 0.5)
	await tween.finished
	queue_free()

func eat():
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color.RED, 0.5)
	hunger = 0


func drink():
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color.BLUE, 0.5)
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
	return age >= MAX_AGE / 5.0

func can_reproduce_with(other: Peebo) -> bool:
	if !can_reproduce():
		return false

	if !other.can_reproduce():
		return false

	# more rules...

	return true
