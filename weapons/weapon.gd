extends Node3D
class_name Weapon

@export var firing_speed : float = 0.5
@export var business_end : Node3D
@export var projectile_damage : float
@export var projectile_speed : float
@export var projectile_lifetime : float

var time_since_last_fire : float = 0
var equipped : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_last_fire += delta

func fire(target : Vector3):
	var direction = business_end.global_position.direction_to(target) * Vector3(1,1,1)
	if time_since_last_fire >= firing_speed:
		emit_projectile(direction)
		time_since_last_fire = 0

func emit_projectile(_direction : Vector3):
	pass
