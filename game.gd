extends Node3D
class_name Game


func _ready() -> void:
	print("GAME READY")


func _input_event(_camera: Camera3D, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_class("InputEventMouse"):
		process_mouse_movement(event)

func process_mouse_movement(event : InputEventMouse):
	print(event.position)
