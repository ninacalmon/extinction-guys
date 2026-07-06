extends Node
class_name CreatureCounter


func _on_creature_died(entity: Creature):
	match entity.get_script():
		Peebo: StatsManager.peebo_amount -= 1
		Mimo: StatsManager.mimo_amount -= 1
		Wungus: StatsManager.wungus_amount -= 1


func _on_creature_born(entity: Creature):
	match entity.get_script():
		Peebo: StatsManager.peebo_amount += 1
		Mimo: StatsManager.mimo_amount += 1
		Wungus: StatsManager.wungus_amount += 1
