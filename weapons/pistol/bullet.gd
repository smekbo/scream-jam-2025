extends Projectile

@export var speed = 100
var collided : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	var collision = move_and_collide(direction.normalized() * delta * speed)
	
	if collision:
		if not collided:
			lifetime = 0.1
			collided = true
