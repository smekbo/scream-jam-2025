extends Node3D
class_name Game


var player : Player
var blood_mesh : Blood_Mesh


func _ready() -> void:
	player = get_node("/root/World/Player")
	blood_mesh = get_node("/root/World/blood_mesh")
