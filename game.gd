extends Node3D
class_name Game


var player : Player
var blood_multimesh : Blood_Multimesh




func _ready() -> void:
	player = get_node("/root/World/Player")
	blood_multimesh = get_node("/root/World/blood_multimesh")
