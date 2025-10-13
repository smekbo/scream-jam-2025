extends CharacterBody3D
class_name Enemy

@export var SPEED : int = 100
@export var HEALTH : int = 6
@export var GIB_COUNT : int = 2

@onready var fx_animation : AnimationPlayer = $AnimationPlayer
@onready var particles : CPUParticles3D = $CPUParticles3D
@onready var gibs_scene : PackedScene = load("res://gibs.tscn")

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



func _on_hurtbox_body_entered(projectile : Projectile) -> void:
	fx_animation.play("hurt")
	var hurt_direction = _game.player.global_position.direction_to(global_position)
	_game.blood_multimesh.blood_splatter(global_position, hurt_direction, projectile.damage)
	particles.direction = -hurt_direction
	projectile.queue_free()
	
	HEALTH -= projectile.damage
	if HEALTH <= 0:
		for i in GIB_COUNT:
			var new_gibs : Gibs = gibs_scene.instantiate()
			new_gibs.global_position = global_position
			get_node("/root/World").add_child(new_gibs)
			new_gibs.toss_gibs(hurt_direction)
		queue_free()
