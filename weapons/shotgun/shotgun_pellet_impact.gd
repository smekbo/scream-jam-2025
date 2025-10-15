extends Node3D

var timer : float = 0

func _process(delta: float) -> void:
	if timer >= 0.5:
		queue_free()
	timer += delta
