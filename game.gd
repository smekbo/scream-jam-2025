extends Node3D
class_name Game


var player : Player
var blood_multimesh : Blood_Multimesh
var score : int :
	set(value):
		score = value
		ui.update_score_display(score)

var gib_spawner : Array[PackedScene]
var gibs_1 : PackedScene = load("res://enemies/gib_scenes/gibs_1.tscn")
var gibs_2 : PackedScene = load("res://enemies/gib_scenes/gibs_2.tscn")
var gibs_3 : PackedScene = load("res://enemies/gib_scenes/gibs_3.tscn")


func _ready() -> void:
	blood_multimesh = get_node("/root/World/blood_multimesh")
	
	gib_spawner = [ gibs_1, gibs_2, gibs_3 ]


func game_over():
	get_tree().change_scene_to_file("res://game_over.tscn")
