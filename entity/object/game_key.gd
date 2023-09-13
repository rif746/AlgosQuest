extends StaticBody2D
class_name GameKey

signal answered(quest_id:int, is_true: bool)

@export var panel: Control

var quest_id: int
var install_question: Callable

func _ready():
	panel.hide()
	if panel.has_signal('answered'):
		panel.answered.connect(_on_quest_answered)
	
	if panel.has_method('install_question'):
		install_question = panel.install_question.bind()

func interaction():
	panel.show()


func _on_quest_answered(is_true: bool):
	answered.emit(quest_id, is_true)
	queue_free()
