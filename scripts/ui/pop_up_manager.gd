extends Control

@export var popup_scene: PackedScene

func _ready():
	EventBus.bag_effect_used.connect(show_pop_up)


func show_pop_up(entity: String, amount: int):
	var popup: EffectPopUp = popup_scene.instantiate()

	add_child(popup)

	popup.show_pop_up(entity, amount)
