extends AnimatableBody3D
class_name Projectile

var direction : Vector3
@export var damage : int
@export var lifetime : float
var lifetimer : float = 0


func _process(delta: float) -> void:
	if lifetimer >= lifetime:
		queue_free()
	lifetimer += delta
	
	process(delta)


func process(_delta):
	pass
