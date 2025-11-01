class_name HurtboxComponent
extends Area2D

@export var health_component: HealthComponent

func _on_area_entered(area: Area2D) -> void:
	print("damage")
	#if area is HitboxComponent:
		#var hitbox = area as HitboxComponent
		#health_component.apply_damage(hitbox.damage)
