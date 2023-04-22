extends Area2D

signal vector_created(vector)

@export var maximum_length = 200

var touch_down := false
var can_procces_vector := false
var position_start := Vector2.ZERO
var position_end := Vector2.ZERO
var ball_position := Vector2.ZERO

var vector := Vector2.ZERO

func _ready() -> void:
	connect("input_event", Callable(self, "_on_input_event"))


func _draw() -> void:
	draw_line(ball_position - global_position,
		ball_position - global_position - vector,
		Color.GREEN, 
		8)
	draw_line(ball_position - global_position, 
		ball_position - global_position + vector,
		Color.RED, 
		16)


func _reset() -> void:
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	vector = Vector2.ZERO
	
	queue_redraw()
	
func change_can_create_vector():
	print(can_procces_vector)
	can_procces_vector = !can_procces_vector
	
func set_new_position(new_position: Vector2):
	ball_position = new_position

func _input(event) -> void:
	if not can_procces_vector:
		return
		
	if event.is_action_released("ui_touch"):
		touch_down = false
		emit_signal("vector_created", vector)
		_reset()
	
	if not touch_down:
		return
	
	if event is InputEventMouseMotion:
		position_end = event.position
		vector = -(position_end - position_start).limit_length(maximum_length)
		
		queue_redraw()


func _on_input_event(_viewport, event, _shape_idx) -> void:
	if not can_procces_vector:
		return
	
	if event.is_action_pressed("ui_touch"):
		touch_down = true
		position_start = event.position
