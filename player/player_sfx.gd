extends Node3D

@onready var player : Player = $".."

# SFX
@onready var sfx_treads : AudioStreamPlayer3D = $treads

var tank_stopped : bool = true


func _process(delta: float) -> void:
	if player.velocity > Vector3.ZERO and tank_stopped:
		sfx_treads.play()
		tank_stopped = false
	if player.velocity > Vector3.ZERO and !tank_stopped:
		treads_loop()
	else:
		sfx_treads.stop()


func treads_loop():
	if !sfx_treads.playing:
		sfx_treads.play()
