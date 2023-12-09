extends Node3D


signal bullet_impacted(location: Vector3, direction: Vector3)
signal current_ammo_changed(new_ammo: int)

@export var max_ammo := 12
var current_ammo := 12

var aim_raycast: RayCast3D = null

@onready var muzzle = $Muzzle


func _ready() -> void:
	current_ammo = max_ammo


func shoot() -> bool:
	if current_ammo == 0:
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
