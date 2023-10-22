extends StaticBody2D
class_name GameKey

@export var panel: LearningPanel
var title: String
var content: String
var is_close: bool = true

func _ready():
	panel.hidden.connect(_on_panel_hide)

func load_content():
	panel.install_window(title, content)

func interaction():
	panel.show()

func _on_panel_hide():
	if is_close:
		is_close = false
		StageManager.object_found_count += 1
