extends VBoxContainer
class_name EffectButton

@export var my_effect: EffectsManager.EffectType

@onready var title: RichTextLabel = $Title
@onready var texture_button: TextureButton = $TextureButton
@onready var price: RichTextLabel = $TextureButton/Price

var effect: BaseEffect

func _ready() -> void:
	setup()

	texture_button.pressed.connect(_on_button_pressed)
	texture_button.mouse_exited.connect(func(): texture_button.button_pressed = false)


func setup():
	effect = EffectsManager.effect_map.get(my_effect)

	title.text = "[b][wave amp=12 freq=4]%s[/wave][/b]" %effect.title

	texture_button.texture_normal = effect.image

	price.text = "[img align=bottom]res://sprites/ui/lf_icon.png[/img] [b]%d Lƒ" %effect.price

func _on_button_pressed():
	if !effect:
		return

	if Bank.buy(effect.price):
		effect.execute_effect()
		effect.update_price()
		setup()

	else:
		shake()

func shake():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(texture_button, "position:x", -8.0, 0.1).from(0.0)
	tween.tween_property(texture_button, "position:x", 8.0, 0.1)
	tween.tween_property(texture_button, "position:x", 0.0, 0.1).from(8.0)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		texture_button.set_instance_shader_parameter("enabled", texture_button.is_hovered())
