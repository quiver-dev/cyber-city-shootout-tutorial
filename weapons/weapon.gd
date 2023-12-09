extends Node3D


signal bullet_impacted(location: Vector3, direction: Vector3)
signal current_ammo_changed(new_ammo: int)

@export var max_ammo := 12
var current_ammo := 12

var aim_raycast: RayCast3D = null
var is_reloading: bool = false

@onready var muzzle = $Muzzle
@onready var anim: AnimationPlayer = find_child("AnimationPlayer", true)


func _ready() -> void:
	current_ammo = max_ammo



func start_reload() -> bool:
	if current_ammo == max_ammo:
		return false

	is_reloading = true

	var reload_time := 2.0
	if anim != null:
		anim.play("Bullets1_Reload")
		reload_time = anim.get_animation("Bullets1_Reload").length - 0.2

	var t = create_tween()
	t.tween_callback(finish_reload).set_delay(reload_time)
	return true


func finish_reload():
	if not is_reloading:
		return

	is_reloading = false

	current_ammo = max_ammo
	current_ammo_changed.emit(current_ammo)


func shoot() -> bool:
	if current_ammo == 0 or is_reloading:
		return false

	current_ammo -= 1
	current_ammo_changed.emit(current_ammo)
	muzzle.show_flash()

	if aim_raycast != null and aim_raycast.is_colliding():
		var hit = aim_raycast.get_collider()
		if hit:
			var cp := aim_raycast.get_collision_point()
			var cn := aim_raycast.get_collision_normal()
			bullet_impacted.emit(cp, cn)

	return true
