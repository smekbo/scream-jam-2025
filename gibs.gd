extends RigidBody3D
class_name Gibs

var life = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	life += delta
	if life >= 0.2:
		contact_monitor = true
		max_contacts_reported = 1


func toss_gibs(direction : Vector3):
	apply_impulse(direction * Vector3(randf(), 2, randf()) * 100, Vector3.ONE)
	

func _on_body_entered(body: Node) -> void:
	_game.blood_multimesh.blood_splatter(global_position + Vector3(0,1,0),Vector3.ONE,1)


func _on_timer_timeout() -> void:
	queue_free()
