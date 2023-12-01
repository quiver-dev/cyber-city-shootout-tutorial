extends Actor


var mouse_sensitivity: float = 0.002

@onready var pivot = $Pivot
@onready var weapon_manager = $Pivot/Camera3D/WeaponManager


func _ready() -> void:
	weapon_manager.set_aim_raycast($Pivot/Camera3D/AimRaycast)
	weapon_manager.weapon_fired.connect(handle_weapon_fired)


func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	super(delta)


func handle_weapon_fired():
	var vertical_options := [0.55, 0.6, 0.65]
	var horizontal_options := [0.18, 0.2, 0.22]

	var actual_vertical = deg_to_rad(vertical_options.pick_random())
	var actual_horizontal = deg_to_rad(horizontal_options.pick_random())
	actual_horizontal *= [-1, 1].pick_random()

	rotate_camera_horizontal(actual_horizontal)
	rotate_camera_vertical(actual_vertical)


func rotate_camera_horizontal(rotation_amount: float):
	rotate_y(rotation_amount)


func rotate_camera_vertical(rotation_amount: float):
	pivot.rotate_x(rotation_amount)
	pivot.rotation.x = clampf(pivot.rotation.x, -1.2, 1.2)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	if event is InputEventMouseMotion:
		var mouse_change = -event.relative
		rotate_camera_horizontal(mouse_change.x * mouse_sensitivity)
		rotate_camera_vertical(mouse_change.y * mouse_sensitivity)
