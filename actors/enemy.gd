extends Actor


@export var attack_radius := 1.5
@export var damage: int = 1.0

var player: Player
var attack_time := 2.0
var is_attacking := false

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var playback: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var attack_time_scale: float = $AnimationTree.get("parameters/attack/TimeScale/scale")
@onready var hurtbox = $Hurtbox/CollisionShape3D


func _ready() -> void:
	attack_time = $Model/melee_enemy/AnimationPlayer.get_animation("attack_2").length


func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		return

	if global_position.distance_to(player.global_position) <= attack_radius:
		direction = Vector3.ZERO
		start_attack()
	elif not is_attacking:
		direction = global_position.direction_to(nav.get_next_path_position())
		if velocity.length() > 0:
			playback.travel("walking")
		else:
			playback.travel("idle")

	var target_xform = global_transform.looking_at(player.global_position)
	global_transform = global_transform.interpolate_with(target_xform, 0.1)

	super(delta)


func start_attack():
	if is_attacking:
		return

	is_attacking = true

	if playback.get_current_node() != "attack":
		playback.travel("attack")
	else:
		playback.start("attack", true)

	var t = create_tween()
	t.set_parallel(true)
	t.tween_callback(finish_attack).set_delay(attack_time / attack_time_scale)
	t.tween_callback(set_hurtbox_disabled.bind(false)).set_delay(1.25 / attack_time_scale)
	t.tween_callback(set_hurtbox_disabled.bind(true)).set_delay(1.5 / attack_time_scale)


func finish_attack():
	is_attacking = false


func set_hurtbox_disabled(disabled: bool):
	hurtbox.set_deferred("disabled", disabled)


func die():
	queue_free()


func _on_nav_tick_timeout() -> void:
	if is_instance_valid(player):
		nav.set_target_position(player.global_position)


func _on_hurtbox_body_entered(body: Node3D) -> void:
	if is_instance_valid(body) and body.has_method("hit"):
		body.hit(damage)
