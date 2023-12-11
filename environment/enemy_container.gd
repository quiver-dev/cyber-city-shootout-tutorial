extends Node3D


func initialize(player: Player):
	for enemy in get_children():
		enemy.player = player
