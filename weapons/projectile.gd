extends Node3D
class_name Projectile

var spawn_location : Vector3
var direction : Vector3
var speed : float
var damage : float
var lifetime : float 
var lifetimer : float = 0


func init(spawn : Vector3, 
		_direction : Vector3, 
		_speed : float, 
		_damage : float, 
		_lifetime : float):
	global_position = spawn
	direction = _direction
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
