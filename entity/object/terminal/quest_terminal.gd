extends StaticBody2D

@onready var stage_data = GameKey.new()
@onready var question_panel = $CanvasLayer/QuestionPanel

func _ready():
	question_panel.install_question(StageManager.question)
	StageManager.can_answer_question.connect(_on_can_answer_question)

func _on_can_answer_question():
	collision_layer = 3

func interaction():
	question_panel.show()
	question_panel.start_timer()
