extends Control
class_name LearningPanel

@onready var title_label = %TitleLabel
@onready var content_label = %ContentLabel

func set_information(title: String, content: String):
	title_label.set_text(title)
	content_label.clear()
	content_label.append_text(content)

func _on_close_button_pressed():
	hide()

func _on_visibility_changed():
	StageManager.panel_visibility_changed.emit(visible)
