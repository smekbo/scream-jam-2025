extends Node3D

@onready var player : Player = $".."

# SFX
@onready var sfx_treads : AudioStreamPlayer3D = $treads



func _process(_delta: float) -> void:
	if player.STATE == player.STATES.STARTUP and !sfx_treads.playing:
		sfx_treads.play()
	if player.STATE == player.STATES.MOVING:
		treads_loop()
	if player.STATE == player.STATES.STOPPING:
		pass


func treads_loop():
	print(sfx_treads.get_playback_position())
	if sfx_treads.get_playback_position() >= 0.28:
		sfx_treads.play()
