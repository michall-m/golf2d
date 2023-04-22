extends RigidBody2D

signal ball_hit
signal ball_position(position: Vector2)
signal stable_ball_position(position: Vector2)

@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var physics = PhysicsMaterial.new()
	physics.set_bounce(0.7)
	physics.set_friction(0.25)
	set_physics_material_override(physics)

func _on_hole_hole_hit():
	get_node(".").visible = false

func launch(impulse: Vector2):
	ball_hit.emit()
	apply_central_impulse(8 * impulse)

func _physics_process(delta):
	ball_position.emit(global_position)
	emit_signal("ball_position", global_position)
	if is_sleeping():
		stable_ball_position.emit(global_position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_sleeping():
		_animated_sprite.play("idle")
	else:
		_animated_sprite.play("run")

