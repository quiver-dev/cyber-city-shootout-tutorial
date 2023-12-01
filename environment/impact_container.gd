extends Node3D


const BULLET_IMPACT = preload("res://environment/bullet_impact.tscn")


func initialize(weapon_manager: WeaponManager):
	weapon_manager.pistol.bullet_impacted.connect(spawn_bullet_impact)


func spawn_bullet_impact(location: Vector3, direction: Vector3):
	var bullet_impact = BULLET_IMPACT.instantiate()
	add_child(bullet_impact)
	bullet_impact.initialize(location, direction)
