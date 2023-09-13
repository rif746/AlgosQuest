extends StaticBody2D
class_name Computer

@onready var learning_panel = $CanvasLayer/LearningPanel

signal window_closed()

func install_computer(title: String, content: String):
	learning_panel.install_window(title, content)

func interaction():
	learning_panel.show()


func _on_learning_panel_hidden():
	window_closed.emit()
