extends Node3D


var aim_raycast: RayCast3D = null

@onready var muzzle = $Muzzle


func shoot():
	muzzle.show_flash()

	if aim_raycast != null and aim_raycast.is_colliding():
		var hit = aim_raycast.get_collider()
		if hit:
			var cp := aim_raycast.get_collision_point()
			print("hit! ", cp)

