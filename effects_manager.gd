extends Node

enum EffectType {WUNGUS_BAG, MIMO_BAG}

var effect_map: Dictionary = {
	EffectType.WUNGUS_BAG : preload("res://scripts/game_effects/wungus_bag_effect.gd").new()
}

func execute_effect(effect: EffectType):
	var effect_script: BaseEffect = effect_map.get(effect)

	if effect_script:
		effect_script.execute_effect()
