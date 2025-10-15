extends Weapon

@export var projectile_scene : PackedScene = load("res://weapons/machine_gun/machinegun_bullet.tscn")


func emit_projectile(direction : Vector3):
	var new_bullet : Projectile = projectile_scene.instantiate()
	new_bullet.init(direction, projectile_speed,projectile_damage, projectile_lifetime)
	get_tree().root.get_child(0).add_child(new_bullet)
	new_bullet.global_position = business_end.global_position
	new_bullet.look_at(direction, Vector3.UP, true)
