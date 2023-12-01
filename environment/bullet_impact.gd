extends Node3D


func initialize(location: Vector3, direction: Vector3):
	global_position = location
	if direction == Vector3.UP:
		rotate_x(deg_to_rad(-90))
	else:
		look_at(global_position + direction)

	var t = create_tween()
	t.tween_callback(queue_free).set_delay(4.0)
