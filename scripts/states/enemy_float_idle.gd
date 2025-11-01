extends state
class_name enemy_float_idle

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var character_body_2d: CharacterBody2D = $"../.."
@onready var ray_cast_2d: RayCast2D = $"../../RayCast2D"

const wander_speed: float = 10
const aggro_range: float = 100
var wander_direction: Vector2
var wander_timer: float = 0

func state_enter():
	randomized_wander()
	
func randomized_wander():
	wander_direction = Vector2(randf_range(-1, 1),randf_range(-1, 1))
	wander_timer = 1
	
	
func state_physics_update(delta: float):
	animated_sprite_2d.play("idle")
	for i in character_body_2d.get_slide_collision_count():
		var collision = character_body_2d.get_slide_collision(i)
		if wander_timer != 1:
			wander_direction = collision.get_normal()
		wander_direction += collision.get_normal()
		wander_timer = 1
	character_body_2d.velocity = lerp(character_body_2d.velocity, wander_direction.normalized() * wander_speed, 0.1)
	if wander_timer > 0:
		wander_timer -= delta
	else:
		randomized_wander()
		
	for player in get_tree().get_nodes_in_group("player"):
		ray_cast_2d.target_position = (player.global_position - ray_cast_2d.global_position).normalized() * aggro_range
		ray_cast_2d.target_position.y -= 10
		if ray_cast_2d.get_collider() != null and ray_cast_2d.get_collider().is_in_group("player"):
			state_transition.emit(self, "enemy_float_chase")
