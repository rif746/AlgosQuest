extends Control
class_name LearningPanel

@onready var title_label = %TitleLabel
@onready var content_label = %ContentLabel

var title: String:
	set(_title):
		title_label.set_text(_title)
		title = _title
var content: String:
	set(_content):
		content_label.clear()
		content_label.append_text(_content)
		content = _content

func set_information(_title: String, _content: String):
	title = _title
	content = _content

func _on_close_button_pressed():
	hide()

func _on_visibility_changed():
	StageManager.panel_visibility_changed.emit(title, visible)
