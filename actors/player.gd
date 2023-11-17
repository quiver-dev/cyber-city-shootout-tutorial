extends Actor


var mouse_sensitivity: float = 0.002

@onready var pivot = $Pivot
@onready var weapon_manager = $Pivot/Camera3D/WeaponManager


func _ready() -> void:
	weapon_manager.set_aim_raycast($Pivot/Camera3D/AimRaycast)


func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	super(delta)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	if event is InputEventMouseMotion:
		var mouse_change = -event.relative
		rotate_y(mouse_change.x * mouse_sensitivity)
		pivot.rotate_x(mouse_change.y * mouse_sensitivity)
		pivot.rotation.x = clampf(pivot.rotation.x, -1.2, 1.2)
