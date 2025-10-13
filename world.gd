extends Node3D

var enemy_scene : PackedScene = load("res://enemy.tscn")


func spawn_enemy():
	var new_enemy = enemy_scene.instantiate()
	new_enemy.global_position = Vector3.ONE
	get_node("/root/World").add_child(new_enemy)
