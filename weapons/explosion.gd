extends Node3D
class_name Explosion

@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var explosion_area : Area3D = $Area3D

var damage : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("explosion")
	
	
func damage_enemies():
	for enemy : Enemy in explosion_area.get_overlapping_bodies():
		enemy.take_damage(damage, global_position)
