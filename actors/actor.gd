extends CharacterBody3D


@export var speed: float = 5.0
@export var jump_force: float = 5.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		var slowdown_speed = speed * 0.25
		velocity.x = move_toward(velocity.x, 0, slowdown_speed)
		velocity.z = move_toward(velocity.z, 0, slowdown_speed)

	move_and_slide()
