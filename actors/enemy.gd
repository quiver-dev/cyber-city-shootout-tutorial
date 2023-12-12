extends Actor


var player: Player

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var playback: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")


func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		return

	direction = global_position.direction_to(nav.get_next_path_position())
	var target_xform = global_transform.looking_at(player.global_position)
	global_transform = global_transform.interpolate_with(target_xform, 0.1)

	if velocity.length() > 0:
		playback.travel("walking")
	else:
		playback.travel("idle")

	super(delta)


func _on_nav_tick_timeout() -> void:
	if is_instance_valid(player):
		nav.set_target_position(player.global_position)
