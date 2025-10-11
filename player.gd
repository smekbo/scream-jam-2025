extends CharacterBody3D
class_name Player

signal player_position_update

@export var SPEED : int = 500
@export var WEAPON : Weapon

@onready var camera : Camera3D = $camera_handle/Camera3D
@onready var crosshair : Node3D = $crosshair
@onready var model_handle : Node3D = $model_handle

var aiming_direction : Vector3


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector")

	if Input.is_action_pressed("fire"):
		WEAPON.fire(aiming_direction)

	velocity.x = SPEED * delta * -1 * (Input.get_action_strength("move_left") - Input.get_action_strength("move_right"))
	velocity.z = SPEED * delta * -1 * (Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward"))
	
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
	var raycast_result
	var ray_length = 100
	var from = camera.project_ray_origin(event.position)
	var to = from + camera.project_ray_normal(event.position) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.collision_mask = 0b00000000_00000000_00000000_00000100
	ray_query.from = from
	ray_query.to = to
	raycast_result = space.intersect_ray(ray_query)
	
	# if the mouse is over ground, move the crosshair and rotate body
	if raycast_result:
		crosshair.global_position = Vector3(raycast_result.position.x, 0, raycast_result.position.z)
		model_handle.look_at(crosshair.global_position)
		aiming_direction = crosshair.global_position - model_handle.global_position
		aiming_direction.y = 0
