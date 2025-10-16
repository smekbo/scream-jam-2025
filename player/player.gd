extends CharacterBody3D
class_name Player

signal player_position_update

@export var HEALTH : float = 100 : 
	set(value):
		HEALTH = value
		ui.update_health_display(HEALTH)
		
@export var SPEED : int = 500
@export var WEAPON : Weapon
@export var BODY_TURN_SPEED : float = 0.02
@export var TURRET_TURN_SPEED : float = 0.1

@onready var camera : Camera3D = $camera_handle/Camera3D
@onready var crosshair : Node3D = $crosshair
@onready var model_handle : Node3D = $model_handle
@onready var weapon_handle : Node3D = $model_handle/catgirltank/Armature/Skeleton3D/BoneAttachment3D/weapon_handle

@onready var tank_skeleton : Skeleton3D = $model_handle/catgirltank/Armature/Skeleton3D
@onready var tank_animation : AnimationTree = $model_handle/AnimationTree
@onready var tank_body_target : Marker3D = $tank_body_target

enum STATES {IDLE, STARTUP, MOVING, STOPPING}
var STATE = STATES.IDLE :
	set(state):
		STATE = state
var aiming_direction : Vector3
var mouse_position_raycast : Dictionary
var x_input = 0 
var y_input = 0

func _ready() -> void:
	_game.player = self
	if weapon_handle.get_children():
		WEAPON = weapon_handle.get_child(0)
		
	
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector")

	if Input.is_action_pressed("fire"):
		if WEAPON:
			WEAPON.fire(crosshair.global_position)

	x_input = (Input.get_action_strength("move_left") - Input.get_action_strength("move_right"))
	y_input = (Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward"))
	
	# if a direction is being pressed, update direction
	if x_input != 0 or y_input != 0:
		tank_body_target.position = Vector3(x_input * 5, 1, y_input * 5) * transform
		
	# rotate skeleton based on inputs
	rotate_body()
	rotate_turret()
	elevate_barrel()
	
	# set velocity to tank's current forward direction
	var body_bone = tank_skeleton.get_bone_global_pose(0)
	if x_input == 0 and y_input == 0:
		velocity = velocity.move_toward(Vector3.ZERO, 0.2)
	else:
		velocity = velocity.move_toward(SPEED * delta * body_bone.basis.z, 0.2)
	
	print(velocity.length())
	if velocity > Vector3.ZERO:
		if STATE == STATES.IDLE:
			STATE = STATES.STARTUP
		elif STATE == STATES.MOVING:
			pass
	else:
		STATE = STATES.IDLE
	
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
	
	# if the mouse is over ground, move the crosshair
	if mouse_position_raycast:
		crosshair.global_position = Vector3(mouse_position_raycast.position.x, 0, mouse_position_raycast.position.z)


func rotate_body():
	var body_transform : Transform3D = tank_skeleton.get_bone_global_pose(0)
	var isolate_rotation = body_transform.interpolate_with(body_transform.looking_at(tank_body_target.global_position), BODY_TURN_SPEED)
	body_transform.basis = Basis(isolate_rotation.basis.x, Vector3(0,1,0), isolate_rotation.basis.z)
	tank_skeleton.set_bone_global_pose(0, body_transform)


func rotate_turret():
	var turret_transform : Transform3D = tank_skeleton.get_bone_global_pose(1)
	turret_transform = turret_transform.interpolate_with(turret_transform.looking_at(crosshair.global_position * transform), TURRET_TURN_SPEED)
	turret_transform.basis = Basis(turret_transform.basis.x, Vector3(0,1,0), turret_transform.basis.z)
	tank_skeleton.set_bone_global_pose(1, turret_transform)


func elevate_barrel():
	var barrel_transform : Transform3D = tank_skeleton.get_bone_global_pose(2)
	var isolate_rotation = barrel_transform.interpolate_with(barrel_transform.looking_at(crosshair.global_position * transform), TURRET_TURN_SPEED)
	barrel_transform.basis = Basis(barrel_transform.basis.x, isolate_rotation.basis.y, barrel_transform.basis.z)
	tank_skeleton.set_bone_global_pose(2, barrel_transform)


func pick_up_weapon(weapon_scene : PackedScene):
	if weapon_handle.get_child(0):
		weapon_handle.get_child(0).queue_free()
	var new_weapon : Weapon = weapon_scene.instantiate()
	weapon_handle.add_child(new_weapon)
	new_weapon.equipped = true
	WEAPON = new_weapon
	

func take_damage(damage : float):
	HEALTH -= damage
	if HEALTH <= 0:
		_game.game_over()
		pass
