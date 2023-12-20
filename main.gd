extends Node3D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	$EnemyContainer.initialize($Player)
	$ImpactContainer.initialize($Player.weapon_manager)
	$HUD.initialize($Player)

	$Player.died.connect(handle_player_death)


func handle_player_death(_dead_actor):
	get_tree().call_deferred("change_scene_to_file", "res://main.tscn")
