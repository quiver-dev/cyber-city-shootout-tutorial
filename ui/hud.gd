extends CanvasLayer


@onready var current_ammo = %CurrentAmmo
@onready var max_ammo = %MaxAmmo
@onready var health_bar = %HealthBar


func initialize(player: Player):
	var pistol = player.weapon_manager.pistol

	current_ammo.text = str(pistol.current_ammo)
	max_ammo.text = str(pistol.max_ammo)

	pistol.current_ammo_changed.connect(handle_current_ammo_changed)

	health_bar.max_value = player.max_health
	health_bar.value = player.current_health

	player.health_changed.connect(handle_player_health_changed)


func handle_current_ammo_changed(new_ammo: int):
	current_ammo.text = str(new_ammo)


func handle_player_health_changed(new_health: int):
	health_bar.value = new_health
