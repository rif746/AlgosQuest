extends Control

@onready var interact_button = $InteractButton

func toggle_interact_button(toggle = false):
	interact_button.visible = toggle
