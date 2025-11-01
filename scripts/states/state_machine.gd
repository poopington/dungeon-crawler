extends Node

@export var initial_state : state

var current_state : state
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is state:
			states[child.name] = child
			child.state_transition.connect(on_child_transition)
	if initial_state:
		initial_state.state_enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.state_update(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.state_physics_update(delta)

func on_child_transition(grab_state, new_state_name):
	if grab_state != current_state:
		return
	var new_state = states.get(new_state_name)
	if !new_state:
		return
	if current_state:
		current_state.state_exit()
	new_state.state_enter()
	current_state = new_state
