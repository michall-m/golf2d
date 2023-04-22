extends RigidBody2D

signal ball_hit
signal ball_position(position: Vector2)
signal stable_ball_position(position: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	var physics = PhysicsMaterial.new()
	physics.set_bounce(0.5)
	physics.set_absorbent(true)
	physics.set_friction(0.6)
	set_physics_material_override(physics)

func _on_hole_hole_hit():
	get_node(".").visible = false

func launch(impulse: Vector2):
	ball_hit.emit()
	apply_central_impulse(5 * impulse)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ball_position.emit(global_position)
	emit_signal("ball_position", global_position)
	if get_node(".").is_sleeping():
		stable_ball_position.emit(global_position)

