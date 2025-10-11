extends Node3D
class_name Game

var player : Player


func _ready() -> void:
	player = get_node("/root/World/Player")
