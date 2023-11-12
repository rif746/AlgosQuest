extends StaticBody2D
class_name GameKey

var title: String
var content: String

func _ready():
	StageManager.close_info_panel.connect(_on_panel_hide)

func interaction():
	StageManager.toggle_info_panel.emit(title, content)

func _on_panel_hide(_title):
	if title == _title:
		StageManager.object_found_count += 1
		StageManager.object_found.emit(title)
		queue_free()
