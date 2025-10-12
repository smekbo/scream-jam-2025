extends MultiMeshInstance3D
class_name Blood_Mesh


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# set all instances out of camera view
	#for i in range(multimesh.instance_count):
		#var mesh_transform = Transform3D()
		#mesh_transform = mesh_transform.translated(Vector3(-1000,0,0))
		#multimesh.set_instance_transform(i, mesh_transform)
	multimesh.instance_count = 1000
	multimesh.visible_instance_count = 1


func blood_splatter(blood_origin : Vector3, direction : Vector3, magnitude : float):
	var blood_scale = Vector3(1, 0, 1)
	var blood_travel : Vector3 = Vector3.ZERO
	for i in magnitude:
		# Adjust blood
		blood_scale = Vector3(1 / i, 0, 1 / i)
		blood_travel = blood_travel + direction.normalized() * magnitude / 2
		
		# Add blood
		var blood_position = Transform3D()
		blood_position = blood_position.translated(blood_origin + blood_travel + Vector3(0,-3,0))
		#blood_position = blood_position.scaled_local(blood_scale)
		multimesh.set_instance_transform(multimesh.visible_instance_count + 1, blood_position)
		multimesh.visible_instance_count += 1
	multimesh.visible_instance_count += 1
