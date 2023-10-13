extends Control
class_name LearningPanel

@onready var title_label = %TitleLabel
@onready var content_label = %ContentLabel

func install_window(title: String, content: String):
	title_label.set_text(title)
	content_label.clear()
	content_label.add_text(content)

func _on_close_button_pressed():
	hide()
