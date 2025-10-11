extends CharacterBody3D

@export var SPEED : int = 1000

@onready var camera : Camera3D = $Camera3D


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector")

	velocity.x = SPEED * delta * -1 * (Input.get_action_strength("move_left") - Input.get_action_strength("move_right"))
	velocity.z = SPEED * delta * -1 * (Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward"))
	
	move_and_slide()
