extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel

var entity: Creature = null

const IMPORTANT_CHANGE := 3
const FOLLOW_SPEED := 12.0
#const OFFSET := Vector2(0, -70)

var last_age := 0
var last_hunger := 0
var last_thirst := 0

func _ready():
	EventBus.entity_hover_entered.connect(_hover_entered)
	EventBus.entity_hover_exited.connect(_hover_exited)
	TimeManager.turn_passed.connect(_turn_passed)

	#scale = Vector2.ONE * 0.9
	modulate.a = 0
	visible = false


func _hover_entered(peebo: Creature):
	entity = peebo

	last_age = peebo.age
	last_hunger = peebo.hunger
	last_thirst = peebo.thirst

	update_popup(false)
	show_popup()


func _hover_exited(_peebo):
	hide_popup()


func show_popup():
	visible = true

	create_tween().kill()

	scale = Vector2.ONE * 0.9
	modulate.a = 0

	var tween := create_tween()

	tween.parallel().tween_property(self, "scale", Vector2.ONE, .15)\
	.set_trans(Tween.TRANS_BACK)

	tween.parallel().tween_property(self, "modulate:a", 1.0, .15)


func hide_popup():
	if !visible:
		return

	var tween := create_tween()

	tween.parallel().tween_property(self, "scale", Vector2.ONE * .9, .12)
	tween.parallel().tween_property(self, "modulate:a", 0.0, .12)

	await tween.finished

	visible = false
	entity = null


func _process(delta):
	if !visible:
		return

	if !is_instance_valid(entity):
		hide_popup()
		return

	global_position = global_position.lerp(
		entity.global_position,
		FOLLOW_SPEED * delta
	)


func _turn_passed():
	if !visible:
		return

	if !is_instance_valid(entity):
		return

	update_popup(true)

	last_age = entity.age
	last_hunger = entity.hunger
	last_thirst = entity.thirst


func update_popup(compare := true):

	rich_text_label.text = """
[wave amp=24 freq=8][b]%s[/b][/wave]
Age %s
Hunger
%s
Thirst
%s
""" % [
		entity.my_name,
		format_age(compare),
		format_hunger(compare),
		format_thirst(compare)
	]


func format_age(compare):

	if !compare:
		return str(entity.age)

	if entity.age == last_age:
		return str(entity.age)

	return "[wave amp=12 freq=2]%d[/wave]" % entity.age


func format_hunger(compare):

	return format_stat(
		entity.hunger,
		entity.MAX_HUNGER,
		last_hunger,
		true,
		compare
	)


func format_thirst(compare):

	return format_stat(
		entity.thirst,
		entity.MAX_THIRST,
		last_thirst,
		true,
		compare
	)

func format_stat(current: int, max_value: int, last: int, bad_when_high: bool, compare: bool) -> String:
	var text := "%d/%d" % [current, max_value]

	var percent := float(current) / max_value

	# Color based on how "bad" the stat is.
	if bad_when_high:
		if percent >= 0.85:
			text = "[pulse color=#ff4444 freq=2]%s[/pulse]" % text
		elif percent >= 0.6:
			text = "[color=orange]%s[/color]" % text
		else:
			text = "[color=lime]%s[/color]" % text
	else:
		if percent <= 0.15:
			text = "[pulse color=#ff4444 freq=2]%s[/pulse]" % text
		elif percent <= 0.4:
			text = "[color=orange]%s[/color]" % text
		else:
			text = "[color=lime]%s[/color]" % text

	if !compare:
		return text

	var diff := current - last

	# No change
	if diff == 0:
		return text

	# Ignore tiny changes (like +1 hunger every turn)
	if abs(diff) < IMPORTANT_CHANGE:
		return text

	# Medium change: show arrow
	if abs(diff) < IMPORTANT_CHANGE:
		if diff > 0:
			return "%s [color=orange]▲%d[/color]" % [text, diff]
		else:
			return "%s [color=lime]▼%d[/color]" % [text, abs(diff)]

	## Large change: animate
	#if diff > 0:
		#return "[shake level=3 rate=25]%s[/shake] [color=orange][b]▲%d[/b][/color]" % [
			#text,
			#diff
		#]

	return "[wave amp=18 freq=5]%s[/wave] [color=lime][b]▼%d[/b][/color]" % [
		text,
		abs(diff)
	]
