extends Node

enum EffectType {PEEBO_BAG, WUNGUS_BAG, MIMO_BAG}

var effect_map: Dictionary = {
	EffectType.PEEBO_BAG : preload("res://scripts/game_effects/peebo_bag_effect.gd").new(),
	EffectType.WUNGUS_BAG : preload("res://scripts/game_effects/wungus_bag_effect.gd").new(),
	EffectType.MIMO_BAG : preload("res://scripts/game_effects/mimo_bag_effect.gd").new()
}


func reset():
	for key in effect_map.keys():
		var effect: BaseEffect = effect_map.get(key)
		effect.price = int(effect.BASE_PRICE * effect.base_price_multiply)
