extends StaticBody2D
class_name GameKey

@export var panel: LearningPanel
var title: String
var content: String

func _ready():
	panel.install_window(title, content)
