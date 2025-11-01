extends state
class_name player_jump

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func state_physics_update(_delta: float):
	var input_axis = Input.get_axis("move_left", "move_right")
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
	animated_sprite_2d.play("jump")
	if owner.is_on_floor():
		state_transition.emit(self, "player_idle")
	else:
		if owner.velocity.y > 0:
			state_transition.emit(self, "player_fall")
