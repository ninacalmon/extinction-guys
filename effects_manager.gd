extends Node

enum EffectType {WUNGUS_BAG, MIMO_BAG}

var effect_map: Dictionary = {
	EffectType.WUNGUS_BAG : preload("res://scripts/game_effects/wungus_bag_effect.gd").new(),
	EffectType.MIMO_BAG : preload("res://scripts/game_effects/mimo_bag_effect.gd").new()
}
