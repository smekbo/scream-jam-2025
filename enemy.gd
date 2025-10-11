extends CharacterBody3D
class_name Enemy

@export var SPEED : int = 100

@onready var fx_animation : AnimationPlayer = $AnimationPlayer

var target : Vector3


func _ready() -> void:
	target = _game.player.global_position
	_game.player.player_position_update.connect(on_target_changed)
	

func _process(delta: float) -> void:
	if target:
		var direction = target - global_position
		velocity = direction * SPEED * delta
		move_and_slide()


func on_target_changed(new_target : Vector3):
	target = new_target


func take_damage():
	fx_animation.play("hurt")
