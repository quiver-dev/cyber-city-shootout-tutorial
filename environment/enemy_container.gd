extends Node3D


const ENEMY = preload("res://actors/enemy.tscn")

var player


func initialize(player: Player):
	self.player = player

	for enemy in get_children():
		setup_enemy(enemy)


func handle_enemy_died(dead_actor: Actor, location: Vector3):
	var new_enemy = ENEMY.instantiate()
	new_enemy.position = location
	setup_enemy(new_enemy)
	add_child(new_enemy)


func setup_enemy(enemy):
	enemy.player = player
	enemy.died.connect(handle_enemy_died.bind(enemy.position))
