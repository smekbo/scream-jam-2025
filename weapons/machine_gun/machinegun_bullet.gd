extends Projectile

var collided : bool = false


func _ready() -> void:
	look_at(direction)


func process(delta: float) -> void:
	global_position = global_position + (direction.normalized() * delta * speed)
	

func on_collision(body : Node3D):
	body.take_damage(damage, global_position)
	lifetime = 0.1
	collided = true
