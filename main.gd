extends Node3D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	$EnemyContainer.initialize($Player)
	$ImpactContainer.initialize($Player.weapon_manager)
	$HUD.initialize($Player)
