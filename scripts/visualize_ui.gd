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
	var input = Input.get_vector("left", "right", "up", "down")
	if joystick:
		var center_bg = self.size / 2 - joystick.size / 2
		joystick.set_position(center_bg + input * draw_scale)
