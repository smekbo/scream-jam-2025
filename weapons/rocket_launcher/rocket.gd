extends Projectile

@onready var explosion_scene : PackedScene = load("res://weapons/explosion.tscn")
@onready var mesh : MeshInstance3D = $MeshInstance3D

var collided : bool = false
var _root 

func _ready() -> void:
	_root = get_tree().root.get_child(0)

func process(delta: float) -> void:
	global_position = global_position + (direction.normalized() * delta * speed)

func on_collision(_body : Node3D):
	var new_explosion : Explosion = explosion_scene.instantiate()
	new_explosion.damage = damage
	get_tree().root.get_child(0).add_child(new_explosion)
	new_explosion.global_position = global_position
	queue_free()
