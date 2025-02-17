extends Control

@export var spiral: Node

var std_radius: float
var echos_per_revolution: float

var cursor_int: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cursor_int = $CursorInt
	std_radius = spiral.std_radius
	echos_per_revolution = spiral.echos_per_revolution


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var current_index = spiral.current_index
	var current_index_int = round(current_index)
	
	var screen_center = get_viewport_rect().size / 2
	var angle = 2 * PI / echos_per_revolution * current_index_int
	cursor_int.position = screen_center - cursor_int.size / 2 + std_radius * Vector2.RIGHT.rotated(angle)
