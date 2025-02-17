extends MarginContainer

const SEPARATION = 124

const TimeAccel = preload("res://scripts/time_accel.gd")

var tween: Tween
var target_index = 0
var tween_time = TimeAccel.new(0.2, 0.3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_index = 0
	_apply_slide(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		_slide_row(-1)
	elif Input.is_action_just_pressed("right"):
		_slide_row(1)
	
	if Input.is_action_pressed("left"):
		_slide_row_hold(-1)
	elif Input.is_action_pressed("right"):
		_slide_row_hold(1)
	
	if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		tween_time.reset_time()

func _slide_row(amount: float) -> void:
		_apply_slide(amount)

func _slide_row_hold(amount: float) -> void:
	if tween and tween.is_running():
		return
	_apply_slide(amount)

func _apply_slide(amount):
	if target_index + amount <= 0 and -$HBoxContainer.get_child_count() < target_index + amount:
		target_index = target_index + amount
		tween_time.speed_up()
		
		var end_pos = Vector2(581 + target_index * SEPARATION, 0)
		tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "position", end_pos, tween_time.get_time())
		tween.tween_interval(tween_time.get_time())
