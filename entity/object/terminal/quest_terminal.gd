extends StaticBody2D

@onready var stage_data = GameKey.new()
@onready var question_panel = $CanvasLayer/QuestionPanel
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	question_panel.install_question(StageManager.question)
	StageManager.can_answer_question.connect(_on_can_answer_question)

func _on_can_answer_question():
	set_collision_layer_value(3, true)
	animated_sprite_2d.show()

func interaction():
	StageManager.pause_game.emit(question_panel)
	question_panel.show()
	question_panel.start_timer()
