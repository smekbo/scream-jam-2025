extends CharacterBody3D

@export var SPEED : int = 100

var target : Vector3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = _game.player.global_position
	_game.player.player_position_update.connect(on_target_changed)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		var direction = target - global_position
		velocity = direction * SPEED * delta
		move_and_slide()


func on_target_changed(new_target : Vector3):
	target = new_target
