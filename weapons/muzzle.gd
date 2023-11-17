extends Marker3D


func _ready() -> void:
	hide()


func show_flash():
	show()
	scale = Vector3(1, 1, 1)
	rotation.z = deg_to_rad(randi_range(0, 180))

	var tween = create_tween()
	tween.tween_property(self, "scale", Vector3(1.25, 1.25, 1.25), 0.02)
	tween.tween_property(self, "scale", Vector3(0.25, 0.25, 0.25), 0.06)
	tween.tween_callback(hide)
