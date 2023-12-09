extends CanvasLayer


@onready var current_ammo = %CurrentAmmo
@onready var max_ammo = %MaxAmmo


func initialize(player: Player):
	var pistol = player.weapon_manager.pistol

	current_ammo.text = str(pistol.current_ammo)
	max_ammo.text = str(pistol.max_ammo)

	pistol.current_ammo_changed.connect(handle_current_ammo_changed)


func handle_current_ammo_changed(new_ammo: int):
	current_ammo.text = str(new_ammo)
