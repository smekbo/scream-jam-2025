extends CharacterBody3D
class_name Player

signal player_position_update

@export var SPEED : int = 500
@export var WEAPON : Weapon

@onready var camera : Camera3D = $camera_handle/Camera3D
@onready var crosshair : Node3D = $crosshair
@onready var model_handle : Node3D = $model_handle

@onready var tank_skeleton : Skeleton3D = $model_handle/test_tank/Armature/Skeleton3D
@onready var tank_animation : AnimationTree = $model_handle/AnimationTree
@onready var tank_body_target : Marker3D = $tank_body_target

var aiming_direction : Vector3
var mouse_position_raycast : Dictionary
var x_input = 0 
var y_input = 0

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector")

	if Input.is_action_pressed("fire"):
		WEAPON.fire(crosshair.global_position)

	x_input = (Input.get_action_strength("move_left") - Input.get_action_strength("move_right"))
	y_input = (Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward"))
	
	if x_input != 0 and y_input != 0:
		tank_body_target.position = Vector3(-x_input * 5, 1, -y_input * 5)
	rotate_body()
	rotate_turret()
	
	var body_bone = tank_skeleton.get_bone_global_pose(0)
	if x_input == 0 and y_input == 0:
		velocity = velocity.move_toward(Vector3.ZERO, 0.2)
	else:
		velocity = SPEED * delta * body_bone.basis.z
	
	move_and_slide()
	emit_signal("player_position_update", global_position)
	
func _input(event: InputEvent) -> void:
	if event.is_class("InputEventMouse"):
		process_mouse_movement(event)


func process_mouse_movement(event : InputEventMouse):
	# figure out how far the mouse is from the middle of the viewport
	#   and shift the camera based on that distance
	var viewport_size : Vector2 = get_viewport().size
	var viewport_center : Vector2 = Vector2(viewport_size.x/2, viewport_size.y/2)
	var mouse_distance_from_center : Vector2 = event.position - viewport_center
	camera.position.x = mouse_distance_from_center.x / 120
	camera.position.z = mouse_distance_from_center.y / 100
	
	# figure out where to put the mouse crosshair on the ground
	var ray_length = 100
	var from = camera.project_ray_origin(event.position)
	var to = from + camera.project_ray_normal(event.position) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.collision_mask = 0b00000000_00000000_00000000_00000100
	ray_query.from = from
	ray_query.to = to
	mouse_position_raycast = space.intersect_ray(ray_query)
	
	# if the mouse is over ground, move the crosshair and rotate body
	if mouse_position_raycast:
		crosshair.global_position = Vector3(mouse_position_raycast.position.x, 0, mouse_position_raycast.position.z)

		#model_handle.look_at(crosshair.global_position)


func rotate_turret():
	var turret_transform : Transform3D = tank_skeleton.get_bone_global_pose(1)
	turret_transform = turret_transform.interpolate_with(turret_transform.looking_at(crosshair.global_position * transform), 0.2)
	tank_skeleton.set_bone_global_pose(1, turret_transform)

func rotate_body():
	var body_transform : Transform3D = tank_skeleton.get_bone_global_pose(0)
	var isolate_rotation = body_transform.interpolate_with(body_transform.looking_at(tank_body_target.global_position), 0.01)
	body_transform.basis = Basis(isolate_rotation.basis.x, Vector3(0,1,0), isolate_rotation.basis.z)
	tank_skeleton.set_bone_global_pose(0, body_transform)
