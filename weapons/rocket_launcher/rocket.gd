extends Projectile

@onready var explosion_scene : PackedScene = load("res://weapons/explosion.tscn")
@onready var mesh : MeshInstance3D = $MeshInstance3Ds

var collided : bool = false


func process(delta: float) -> void:
	global_position = global_position + (direction.normalized() * delta * speed)


func on_collision(_body : Node3D):
	var new_explosion : Explosion = explosion_scene.instantiate()
	new_explosion.damage = damage
	new_explosion.global_position = global_position
	get_node("/root/World").add_child(new_explosion)
	queue_free()
