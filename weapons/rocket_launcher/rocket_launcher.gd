extends Weapon

@export var projectile_scene : PackedScene


func emit_projectile(direction : Vector3):
	var new_rocket : Projectile = projectile_scene.instantiate()
	new_rocket.init(business_end.global_position,direction, projectile_speed, projectile_damage, projectile_lifetime)
	get_node("/root/World").add_child(new_rocket)
	new_rocket.look_at(direction)
