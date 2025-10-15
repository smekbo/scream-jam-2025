extends Weapon

@export var projectile_scene : PackedScene


func emit_projectile(direction : Vector3, target : Vector3):
	var new_bullet : Projectile = projectile_scene.instantiate()
	new_bullet.global_position = business_end.global_position
	new_bullet.direction = direction
	get_node("/root").add_child(new_bullet)
