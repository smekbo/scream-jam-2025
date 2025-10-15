extends Weapon

@export var projectile_scene : PackedScene

func emit_projectile(direction : Vector3):
	var new_rocket : Projectile = projectile_scene.instantiate()
	new_rocket.init(direction, projectile_speed, projectile_damage, projectile_lifetime)
	get_tree().root.get_child(2).add_child(new_rocket)
	new_rocket.global_position = business_end.global_position
	new_rocket.look_at(direction, Vector3.UP, true)
