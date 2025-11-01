extends state
class_name enemy_float_chase

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var character_body_2d: CharacterBody2D = $"../.."
@onready var ray_cast_2d: RayCast2D = $"../../RayCast2D"

const chase_speed: float = 20
const aggro_range: float = 200
var chase_offset: Vector2
var wander_timer: float = 0

func state_enter():
	chase_offset = Vector2(randf_range(-1, 1),randf_range(-1, 0)).normalized() * 25
	
	
func state_physics_update(delta: float):
	animated_sprite_2d.play("idle")
	for i in character_body_2d.get_slide_collision_count():
		var collision = character_body_2d.get_slide_collision(i)
		character_body_2d.velocity += collision.get_normal() * 10
	for player in get_tree().get_nodes_in_group("player"):
		character_body_2d.velocity = lerp(character_body_2d.velocity, (player.global_position - character_body_2d.global_position + chase_offset).normalized() * chase_speed, 0.1)

		ray_cast_2d.target_position = ((player.global_position + Vector2(0, -8)) - ray_cast_2d.global_position).normalized() * aggro_range
		if ray_cast_2d.get_collider() == null:
			state_transition.emit(self, "enemy_float_investigate")
		elif not ray_cast_2d.get_collider().is_in_group("player"):
			state_transition.emit(self, "enemy_float_investigate")
