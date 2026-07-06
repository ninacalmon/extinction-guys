extends Node2D
class_name PeeboEgg

var hatching: bool = false

var tile_pos: Vector2i

var egg_age: int = 0
const AGE_TO_HATCH: int = 5

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	TimeManager.turn_passed.connect(_on_turn)



func _on_turn():
	if hatching:
		return

	egg_age += 1
	animation_player.play("egg_shake_min")

	if egg_age >= AGE_TO_HATCH:
		hatch()


func hatch():
	hatching = true

	animation_player.play("egg_shake_max")
	await animation_player.animation_finished

	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5)
	await tween.finished

	Globals.peebo_instanciator.create_new_peebo(tile_pos)

	queue_free()
