extends Object
class_name TimeAccel

var decay_speed: float
var initial_time: float
var n: int

func _init(start_time, decay_speed) -> void:
	self.decay_speed = decay_speed
	self.initial_time = start_time
	self.n = 0

func get_time() -> float:
	return self.initial_time * sample_exp(n)

func reset_time():
	self.n = 0

func speed_up():
	self.n += 1

func sample_exp(val: int) -> float:
	return exp(- self.decay_speed * val)
