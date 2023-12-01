extends Node3D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	$ImpactContainer.initialize($Player.weapon_manager)
