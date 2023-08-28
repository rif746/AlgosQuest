extends StaticBody2D

@onready var scene = load($ItemArea.window_property).instantiate()

signal load_window(title, materi)
signal window_closed()

func _ready():
	add_child(scene)
	scene.close_window.connect(func(): window_closed.emit())

func load_computer(title, description):
	load_window.emit(title, description)	

func player_action():
	get_tree().paused = true
	scene.show()
