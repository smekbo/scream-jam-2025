extends AnimatableBody3D
class_name Projectile

var direction : Vector3
@export var damage : int
@export var lifetime : int

func _ready() -> void:
	var lifetimer : Timer = Timer.new()
	lifetimer.wait_time = lifetime
	lifetimer.start()
