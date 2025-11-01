extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var desired_offset: Vector2
var min_offset = -100
var max_offset = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	desired_offset = (get_global_mouse_position() - position) * 0.2
	desired_offset.x = clamp(desired_offset.x, min_offset, max_offset)
	desired_offset.y = clamp(desired_offset.y, min_offset / 2.0, max_offset / 2.0)
	
	global_position = get_parent().get_node("player").global_position + desired_offset
