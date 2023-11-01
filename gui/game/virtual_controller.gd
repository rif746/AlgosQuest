extends Control

@onready var interact_button = $InteractButton
@onready var progress_button = $ProgressButton


func toggle_interact_button(toggle = false):
	interact_button.visible = toggle


func toggle_progress_button(toggle = false):
	progress_button.visible = toggle
