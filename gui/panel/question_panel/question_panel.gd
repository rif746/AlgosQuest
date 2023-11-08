extends Control

@onready var content_label = %ContentLabel
@onready var answer_grid = %AnswerGrid
@onready var answer_list = %AnswerList
@onready var sfx_control = $sfx_control
@onready var point_label = %PointLabel
@onready var timer = $Timer
@onready var timer_label = %TimerLabel

var quest: Array[Quest]
var question_loaded: int = 0

func _ready():
	install_question(StageLoader.stage[0].quest)

func _process(_delta):
	if not timer.is_stopped():
		var time_left = timer.time_left
		var minutes = time_left / 60;
		var seconds = fmod(time_left, 60)
		timer_label.set_text(str("%02d:%02d" % [minutes, seconds]))
		StageManager.question_time = time_left


func install_question(_quest: Array[Quest]):
	for q in _quest:
		if quest.find(q) == -1:
			StageManager.question_time += 20
			if StageManager.question_answered.find(q.text) == -1:
				quest.append(q)
	quest.shuffle()
	load_question()


func load_question():
	content_label.clear()
	content_label.add_text(quest[question_loaded].text)
	clear_answer_button()
	load_answer(quest[question_loaded].answer)
	sfx_control.install_sounds(answer_grid)


func clear_answer_button():
	for button in answer_grid.get_children():
		answer_grid.remove_child(button)


func load_answer(answers: Array[QuestAnswer]):
	answers.shuffle()
	var button_group = ButtonGroup.new()
	button_group.pressed.connect(_on_answer_button_pressed)
	
	for answer in answers:
		var button = Button.new()
		button.set_meta("correct", answer.correct)
		button.set_custom_minimum_size(Vector2(150, 40))
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.button_group = button_group
		button.toggle_mode = true
		button.set_text(answer.text)
		answer_grid.add_child(button)
		button.size = Vector2(150, 40)


func _on_answer_button_pressed(button: Button):
	var correct = button.get_meta("correct")
	if not correct:
		#point_label.set_text(str(StageManager.question_correct * (100/quest.size())))
		timer.start(timer.time_left - 30)
	StageManager.question_answered.push_back(quest[question_loaded].text)
	if question_loaded != quest.size()-1:
		question_loaded += 1
		load_question()
	else:
		hide()
		StageManager.exit_door_open.emit()


func _on_close_button_pressed():
	hide()


func start_timer():
	timer.start(StageManager.question_time)


func _on_timer_timeout():
	hide()
	StageManager.game_over.emit()


func _on_hidden():
	timer.stop()
	SceneChanger.resume_game(self)
