extends Control

@export var std_radius: float = 300
@export var delta_radius: float = 20
@export var echos_per_revolution: float = 12

const InputAngle = preload("res://input_angle.gd")

var current_index_float = 0
var input_angle = InputAngle.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var delta_rad = 2 * PI / echos_per_revolution
	var center = self.size/2
	
	var input_rad = input_angle.get_input_angle()
	current_index_float = input_rad / delta_rad
	var r_offset = current_index_float * delta_radius
	
	var angle = 0.0
	var radius = std_radius - r_offset
	for child in self.get_children():
		child.position = (center - child.size / 2) + radius * Vector2.RIGHT.rotated(angle)
		var scale = radius / std_radius
		
		child.visible = scale > 0.1
		child.scale = sqrt(radius / std_radius) * Vector2.ONE
		
		var transparency = clamp((900 - radius)/300, 0, 1)
		child.modulate = Color(1,1,1,transparency)
		
		angle += delta_rad
		radius += delta_radius
