extends Node3D
class_name Weapon

@export var projectile_damage : int = 10
@export var firing_speed : float = 0.5
@export var business_end : Node3D

var time_since_last_fire : float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_last_fire += delta

func fire(target : Vector3):
	var direction = business_end.global_position.direction_to(target) * Vector3(1,0,1)
	if time_since_last_fire >= firing_speed:
		emit_projectile(direction)
		print("Bang!")
		time_since_last_fire = 0

func emit_projectile(_direction : Vector3):
	pass
