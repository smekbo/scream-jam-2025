extends Node3D
class_name Projectile

var spawn_location : Vector3
var direction : Vector3
var target : Vector3
var speed : float
var damage : float
var lifetime : float 
var lifetimer : float = 0


func init(_direction : Vector3,
		_target : Vector3,
		_speed : float, 
		_damage : float, 
		_lifetime : float):
	direction = _direction
	target = _target
	speed = _speed
	damage = _damage
	lifetime = _lifetime


func _process(delta: float) -> void:
	if lifetimer >= lifetime:
		queue_free()
	lifetimer += delta
	
	process(delta)


func process(_delta):
	pass
