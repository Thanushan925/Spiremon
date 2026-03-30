extends Resource
class_name StatusEffect

@export var name: String
@export var duration: int = 3
@export var damage_per_turn: int = 0
@export var apply_message: String = "{target} gained {status}!"
@export var refresh_message: String = "{target}'s {status} was refreshed!"
