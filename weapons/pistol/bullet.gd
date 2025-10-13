extends Projectile

@export var speed = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_collide(direction.normalized() * delta * speed)
