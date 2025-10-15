extends Weapon

@export var projectile_scene : PackedScene = load("res://weapons/machine_gun/machinegun_bullet.tscn")


func emit_projectile(direction : Vector3):
	var new_bullet : Projectile = projectile_scene.instantiate()
	new_bullet.init(business_end.global_position, direction, projectile_speed,projectile_damage, projectile_lifetime)
	get_node("/root").add_child(new_bullet)
