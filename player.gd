class_name Player
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $state_machine
@export var health_component: HealthComponent


const SPEED: float = 100.0
const JUMP_VELOCITY: float = -275.0
var coyote_jump_timer: float = 0.0

func _ready() -> void:
	for grab_state in state_machine.get_children():
		grab_state = state_machine

func _physics_process(delta: float) -> void:
	var input_axis = Input.get_axis("move_left", "move_right")
	movement_handler(input_axis)
	gravity_handler(delta)
	jump_handler(delta)
	one_way_collisions()
	move_and_slide()


func movement_handler(input_axis):
	if input_axis:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, input_axis * SPEED, 12)
		else:
			velocity.x = move_toward(velocity.x, input_axis * SPEED, 7)
	else:
		velocity.x = move_toward(velocity.x, 0, 6)


func gravity_handler(delta):
	if not is_on_floor():
		if velocity.y < 0:
			velocity += get_gravity() * delta * 0.7
		else:
			velocity += get_gravity() * delta * 0.9


func jump_handler(delta):
	if is_on_floor():
		coyote_jump_timer = 0.1
	elif coyote_jump_timer > 0:
		coyote_jump_timer -= delta
	if Input.is_action_just_pressed("jump") and coyote_jump_timer > 0:
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = velocity.y / 2


func one_way_collisions():
	if Input.is_action_pressed("down"):
		set_collision_mask_value(3, false)
	else:
		set_collision_mask_value(3, true)
