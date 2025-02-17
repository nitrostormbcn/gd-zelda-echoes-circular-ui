extends Control

@export var left: StringName
@export var right: StringName
@export var up: StringName
@export var down: StringName
@export var draw_scale: float = 30

var joystick: Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	joystick = $Joystick

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Vector2.ZERO
	input.x -= Input.get_action_strength(left)
	input.x += Input.get_action_strength(right)
	input.y -= Input.get_action_strength(up)
	input.y += Input.get_action_strength(down)
	if input.length() > 0:
		input = input.normalized()
	if joystick:
		var center_bg = self.size / 2 - joystick.size / 2
		joystick.set_position(center_bg + input * draw_scale)
