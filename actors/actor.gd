extends CharacterBody3D
class_name Actor


signal health_changed(new_health: int)
signal died(actor: Actor)

@export var speed: float = 5.0
@export var jump_force: float = 5.0

@export var max_health: int = 10
@onready var current_health: int = max_health:
	set(value):
		current_health = clampi(value, 0, max_health)
		health_changed.emit(current_health)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction: Vector3 = Vector3.ZERO


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		var slowdown_speed = speed * 0.25
		velocity.x = move_toward(velocity.x, 0, slowdown_speed)
		velocity.z = move_toward(velocity.z, 0, slowdown_speed)

	move_and_slide()


func hit(damage: int):
	current_health -= damage
	if current_health <= 0:
		die()


func die():
	died.emit(self)
