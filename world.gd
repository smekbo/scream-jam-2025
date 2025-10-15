extends Node3D

var enemy_scene : PackedScene = load("res://enemies/biohoover/biohoover.tscn")

func spawn_enemy():
	var new_enemy = enemy_scene.instantiate()
	get_tree().root.get_child(0).add_child(new_enemy)
	new_enemy.global_position = Vector3.ONE
