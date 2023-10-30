extends Node3D


@onready var animation_player = $arm_rig/AnimationPlayer


func _ready() -> void:
	animation_player.play("Gun1_Idle_NoMovement")
