extends Node3D

@export var weapon_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var weapon_model = weapon_scene.instantiate()
	$pickup_model.add_child(weapon_model)


func _on_pickup_radius_body_entered(body: Player) -> void:
	body.pick_up_weapon(weapon_scene)
	queue_free()
