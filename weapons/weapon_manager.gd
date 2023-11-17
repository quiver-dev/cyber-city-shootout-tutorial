extends Node3D


var aim_raycast: RayCast3D = null

@onready var animation_player = $arm_rig/AnimationPlayer


func _ready() -> void:
	animation_player.play("Gun1_Idle_NoMovement")


func set_aim_raycast(raycast: RayCast3D):
	aim_raycast = raycast
	#TODO also make sure to pass this down into our gun
