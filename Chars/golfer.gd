extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal golfer_position(position: Vector2)

@onready var _animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	golfer_position.emit(global_position)
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	# move_and_collide()
	
func _process(_delta):
	if not is_on_floor():
		_animated_sprite.play("jump")
	elif velocity.x == 0:
		_animated_sprite.play("idle")
	else:
		_animated_sprite.play("run")
