class_name HealthComponent
extends Node

@export var max_health: float = 1.0

var health: float

func _ready() -> void:
	health = max_health

func apply_damage(damage: float) -> void:
	health -= damage
	
	if health <= 0:
		get_parent().queue_free()
