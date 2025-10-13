extends MultiMeshInstance3D
class_name Blood_Multimesh

var mesh_index : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# set all instances out of camera view
	#for i in range(multimesh.instance_count):
		#var mesh_transform = Transform3D()
		#mesh_transform = mesh_transform.translated(Vector3(-1000,0,0))
		#multimesh.set_instance_transform(i, mesh_transform)
	multimesh.instance_count = 1000
	multimesh.visible_instance_count = 0


func blood_splatter(blood_origin : Vector3, direction : Vector3, magnitude : float):
	direction = Vector3(direction.x, 0, direction.z)
	var blood_scale = Vector3(magnitude, 1, magnitude)
	var blood_travel : Vector3 = Vector3.ZERO
	for i in magnitude:
		# Adjust blood
		blood_scale = Vector3(magnitude/(i+1), 1, magnitude/(i+1))
		if i <= 0:
			blood_scale = Vector3(magnitude, 1, magnitude)
		blood_travel = blood_travel + direction.normalized() * magnitude / (magnitude / 2)
		# Add blood
		var blood_position = Transform3D()
		blood_position = blood_position.scaled(blood_scale)
		blood_position = blood_position.translated(blood_origin + blood_travel + Vector3(randf()*1.5,-3,randf()*1.5))
		
		# if all meshes are visible, just tick down the counter
		if multimesh.visible_instance_count == multimesh.instance_count and mesh_index >= multimesh.instance_count:
			mesh_index = 0
			
		multimesh.set_instance_transform(mesh_index, blood_position)
		mesh_index += 1
		multimesh.visible_instance_count += 1
	multimesh.visible_instance_count += 1
