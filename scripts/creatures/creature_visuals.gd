extends Node
class_name Visuals

@export var creature: Creature
@export var sprite: AnimatedSprite2D
@export var reaction_sprite: Sprite2D
@export var animation_player: AnimationPlayer
@export var blood_gpu_particles: GPUParticles2D


func die(bleed: bool = false):
	if bleed:
		blood_gpu_particles.emitting = true

	#sprite.flip_v = true

	sprite.material = null

	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.5)

	await tween.finished
