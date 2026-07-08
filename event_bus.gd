extends Node

signal entity_hover_entered(entity: Creature)
signal entity_hover_exited(entity: Creature)

signal died(entity: Creature)
signal born(entity: Creature)

signal bag_effect_used(creature: String, amount: int)

signal lost_game(creature: String)
