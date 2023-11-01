extends Control

@onready var content_label = %ContentLabel
@onready var answer_grid = %AnswerGrid
@onready var sfx_control = $sfx_control
@onready var point_label = %PointLabel
@onready var timer = $Timer
@onready var timer_label = %TimerLabel

var quest: Array[Quest]
var question_loaded: int = 0


func _process(_delta):
	if not timer.is_stopped():
		var minutes = timer.time_left / 60;
		var seconds = fmod(timer.time_left, 60)
		timer_label.set_text(str("%02d:%02d" % [minutes, seconds]))


func install_question(_quest: Array[Quest]):
	quest = _quest
	quest.shuffle()
	load_question()
	StageManager.question_time = _quest.size() * 20
	timer.wait_time = StageManager.question_time


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
		button.set_text(answer.text)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.button_group = button_group
		button.toggle_mode = true
		
		answer_grid.add_child(button)


func _on_answer_button_pressed(button: Button):
	var correct = button.get_meta("correct")
	if correct:
		StageManager.question_correct += 1
		point_label.set_text(str(StageManager.question_correct * (100/quest.size())))
	else:
		StageManager.question_incorrect += 1
	
	if question_loaded != quest.size()-1:
		question_loaded += 1
		load_question()
	else:
		hide()
		StageManager.exit_door_open.emit()


func _on_close_button_pressed():
	hide()
	timer.stop()


func start_timer():
	timer.start()


func _on_timer_timeout():
	StageManager.game_over.emit()
