extends CharacterBody3D
class_name Enemy

@export var SPEED : int = 250
@export var HEALTH : float = 6
@export var ATTACK_SPEED : float = 2
@export var DAMAGE : float = 5
@export var VALUE : int = 5
@export var GIB_COUNT : int = 2
@export var GIB_SCALE : float = 0.5

@onready var fx_animation : AnimationPlayer = $AnimationPlayer
@onready var particles : CPUParticles3D = $CPUParticles3D
@onready var model_handle : Node3D = $model_handle
@onready var hurtbox : Area3D = $model_handle/hurtbox

var target : Vector3
var attack_timer := 0.0


func _ready() -> void:
	target = _game.player.global_position
	_game.player.player_position_update.connect(on_target_changed)
	

func _process(delta: float) -> void:
	if target:
		var direction = target - global_position
		velocity = direction.normalized() * SPEED * delta
		model_handle.look_at(target)
		move_and_slide()
	
	if attack_timer >= ATTACK_SPEED:
		attack()
		attack_timer = 0
	attack_timer += delta


func attack():
	for body : Player in hurtbox.get_overlapping_bodies():
		body.take_damage(DAMAGE)


func on_target_changed(new_target : Vector3):
	target = new_target


func _on_hitbox_body_entered(projectile : Projectile) -> void:
	take_damage(projectile.damage, projectile.global_position)


func take_damage(damage : float, _damage_origin : Vector3):
	fx_animation.play("hurt")
	
	var hurt_direction = _game.player.global_position.direction_to(global_position)
	_game.blood_multimesh.blood_splatter(global_position, hurt_direction, damage)
	particles.direction = -hurt_direction
	
	HEALTH -= damage
	if HEALTH <= 0:
		for i in GIB_COUNT:
			var new_gibs : Gibs = _game.gib_spawner[randi() % _game.gib_spawner.size()].instantiate()
			get_tree().root.get_child(0).add_child(new_gibs)
			new_gibs.global_position = global_position
			new_gibs.toss_gibs(hurt_direction, GIB_SCALE)
		_game.score += VALUE
		queue_free()
