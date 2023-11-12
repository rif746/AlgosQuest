extends Control

@onready var interact_button = %InteractButton
@onready var progress_button = %ProgressButton
@onready var virtual_joystick = $VirtualJoystick
@onready var keyboard_helper = $KeyboardHelper
@onready var interaction_helper = %InteractionHelper
@onready var progress_helper = %ProgressHelper


func _ready():
	keyboard_or_touchscreen(keyboard_helper, virtual_joystick)


func toggle_interact_button(toggle = false):
	keyboard_or_touchscreen(interaction_helper, interact_button, toggle)


func toggle_progress_button(toggle = false):
	keyboard_or_touchscreen(progress_helper, progress_button, toggle)


func keyboard_or_touchscreen(keyboard: Node, touchscreen: Node, toggle: bool = true):
	if DisplayServer.is_touchscreen_available():
		keyboard.visible = false
		touchscreen.visible = toggle
	else:	
		keyboard.visible = toggle
		touchscreen.visible = false
