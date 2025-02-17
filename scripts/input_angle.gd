extends Object
class_name InputAngle

var offset_angle: float = 0

func _init() -> void:
	pass

func get_input_angle() -> float:
	var input = _read_input()
	if input.length() <= 0.2:
		return offset_angle
	var angle = Vector2.from_angle(offset_angle).angle_to(input)
	offset_angle += angle
	offset_angle = clamp(offset_angle, 0, 15.75 * 2 * PI)  # Max number of turns
	return offset_angle

func _read_input() -> Vector2:
	var input = Input.get_vector("left", "right", "up", "down")
	return input
