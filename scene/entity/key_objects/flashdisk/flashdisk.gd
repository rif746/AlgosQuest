extends Sprite2D

@onready var scene = load($ItemArea.window_property).instantiate()

var mission_id: int
var ready_to_clear = false

signal load_window(id, title, materi)
signal pick_up(mission_id)

func _ready():
	add_child(scene)
	scene.close_window.connect(_on_window_property_window_closed)

func load_mission(mis_id, instruction, answer):
	mission_id = mis_id
	load_window.emit(mission_id, instruction, answer)

func player_action():
	if ready_to_clear:
		queue_free()
		pick_up.emit(mission_id)
	else:
		get_tree().paused = true
		scene.show()


func set_label(text: String):
	$Label.set_text(text)

func _on_window_property_window_closed():
	ready_to_clear = true
