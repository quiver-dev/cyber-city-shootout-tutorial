extends Node3D
class_name WeaponManager


signal weapon_fired

var aim_raycast: RayCast3D = null

@onready var default_position = position
@onready var pistol = $arm_rig/Arms/Skeleton3D/BoneAttachment3D/Pistol
@onready var animation_player = $arm_rig/AnimationPlayer


func _ready() -> void:
	animation_player.play("Gun1_Idle_NoMovement")


func set_aim_raycast(raycast: RayCast3D):
	aim_raycast = raycast
	pistol.aim_raycast = raycast


func kick_weapon():
	var t = create_tween()
	t.set_parallel(true)
	t.tween_property(self, "rotation:x", deg_to_rad(-5), 0.05).as_relative()
	t.tween_property(self, "position:z", 0.15, 0.05).as_relative()
	t.set_parallel(false)

	t.tween_property(self, "rotation:x", 0.0, 0.05)
	t.tween_property(self, "position:z", default_position.z, 0.05)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		var gun_was_shot: bool = pistol.shoot()
		if gun_was_shot:
			kick_weapon()
			weapon_fired.emit()
	if event.is_action_pressed("reload"):
		var reload_started: bool = pistol.start_reload()
		if reload_started:
			animation_player.play("Gun1_Reload")
