extends Control

@export var spiral: Node

var std_radius: float
var echos_per_revolution: float

var cursor_float: Node
var cursor_int: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cursor_float = $CursorFloat
	cursor_int = $CursorInt
	std_radius = spiral.std_radius
	echos_per_revolution = spiral.echos_per_revolution


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var current_index_float = spiral.current_index_float
	var current_index_int = round(current_index_float)
	
	var screen_center = get_viewport_rect().size / 2
	var angle_hint = 2 * PI / echos_per_revolution * current_index_float
	var angle = 2 * PI / echos_per_revolution * current_index_int
	cursor_int.position = screen_center - cursor_int.size / 2 + std_radius * Vector2.RIGHT.rotated(angle)
	cursor_float.position = screen_center - cursor_float.size / 2 + std_radius * Vector2.RIGHT.rotated(angle_hint)
