extends Node3D


var aim_raycast: RayCast3D = null

@onready var pistol = $arm_rig/Arms/Skeleton3D/BoneAttachment3D/Pistol
@onready var animation_player = $arm_rig/AnimationPlayer


func _ready() -> void:
	animation_player.play("Gun1_Idle_NoMovement")


func set_aim_raycast(raycast: RayCast3D):
	aim_raycast = raycast
	pistol.aim_raycast = raycast


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		pistol.shoot()
