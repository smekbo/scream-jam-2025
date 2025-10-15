extends Projectile

var collided : bool = false


func process(delta: float) -> void:
	global_position = global_position + (direction.normalized() * delta * speed)


func on_collision(body : Node3D):
	body.take_damage(damage, global_position)
	lifetime = 0.1
	collided = true
