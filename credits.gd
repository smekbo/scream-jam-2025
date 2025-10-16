extends Control

@onready var peplat_model = $VBoxContainer/SubViewportContainer/SubViewport/catgirltank


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	peplat_model.rotate(Vector3.UP, delta)
