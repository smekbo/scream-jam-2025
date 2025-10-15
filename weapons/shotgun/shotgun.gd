extends Weapon

@onready var pellet_impact_scene : PackedScene = load("res://weapons/shotgun/shotgun_pellet_impact.tscn")
@onready var ray_container : Node3D = $Marker3D


func emit_projectile(_direction : Vector3):
	for ray : RayCast3D in ray_container.get_children():
		if ray.is_colliding():
			var body = ray.get_collider()
			var collision_point = ray.get_collision_point()
			var new_impact = pellet_impact_scene.instantiate()
			get_node("/root/World").add_child(new_impact)
			new_impact.global_position =  collision_point + Vector3(0,0,0)
			body.take_damage(projectile_damage, collision_point)

func bullet_tracers():
	pass
