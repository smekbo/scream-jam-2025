extends Control

@onready var ui_health_value : Label = $health_value
@onready var ui_score_value : Label = $score_value
@onready var ui_state_value : Label = $state_value


func update_health_display(value):
	ui_health_value.text = str(value)

func update_score_display(value):
	ui_score_value.text = str(value)

func update_state_display(value):
	ui_state_value.text = str(value)
