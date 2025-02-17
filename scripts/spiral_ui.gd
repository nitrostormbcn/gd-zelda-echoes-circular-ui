extends Control

@export var std_radius: float = 150
@export var delta_radius: float = 25
@export var echos_per_revolution: float = 8

const InputAngle = preload("res://scripts/input_angle.gd")

var current_index = 0
var input_angle = InputAngle.new()

var selected_index = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var delta_rad = 2 * PI / echos_per_revolution
	var center = self.size/2
	
	var input_rad = input_angle.get_input_angle()
	current_index = round(input_rad / delta_rad)
	var r_offset = current_index * delta_radius
	
	var angle = 0.0
	var radius = std_radius - r_offset
	
	if current_index == selected_index:
		return
	selected_index = current_index
	
	for child in self.get_children():
		var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR).set_parallel(true)
		var clamp_radius = clamp(radius, 0, INF)
		var position = (center - child.size / 2) + clamp_radius * Vector2.RIGHT.rotated(angle)
		tween.tween_property(child, "position", position, 0.15)
		
		var scale = sqrt(clamp_radius / std_radius) * Vector2.ONE
		tween.tween_property(child, "scale", scale, 0.15)
		
		var transparency = clamp((clamp_radius - 50)/30 , 0, clamp((320 - clamp_radius)/30, 0, 1))
		var modulate = Color(1,1,1,transparency)
		tween.tween_property(child, "modulate", modulate, 0.05)
		
		angle += delta_rad
		radius += delta_radius
