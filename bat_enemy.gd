extends CharacterBody2D

@onready var state_machine: Node = $state_machine

func _ready() -> void:
	for grab_state in state_machine.get_children():
		grab_state = state_machine

func _physics_process(delta: float) -> void:
	move_and_slide()
