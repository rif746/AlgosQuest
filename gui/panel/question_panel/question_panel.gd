extends Control

@onready var content_label = %ContentLabel
@onready var answer_grid = %AnswerGrid
@onready var sfx_control = $sfx_control
@onready var timer = $Timer
@onready var timer_label = %TimerLabel
@onready var quest_label = %QuestLabel

var quest: Array[Quest]
var question_loaded: int = 0

func _ready():
	var _quest = StageLoader.stage[0].quest
	_quest.shuffle()
	var limit = floor(_quest.size() / 2)
	for i in _quest.size():
		if quest.find(_quest[i]) == -1 && i < limit:
			StageManager.question_time += 20
			if StageManager.question_answered.find(_quest[i].text) == -1:
				quest.append(_quest[i])
	load_question()

func _process(_delta):
	if not timer.is_stopped():
		var time_left = timer.time_left
		var minutes = time_left / 60;
		var seconds = fmod(time_left, 60)
		timer_label.set_text(str("%02d:%02d" % [minutes, seconds]))
		StageManager.question_time = time_left


func load_question():
	quest_label.set_text("Quest %d of %d" % [question_loaded + 1, quest.size()])
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
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.button_group = button_group
		button.mouse_filter = button.MOUSE_FILTER_PASS
		button.toggle_mode = true
		button.show_behind_parent = true
		button.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		
		var label = Label.new()
		label.set_text(answer.text)
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		label.size_flags_vertical = Control.SIZE_EXPAND_FILL
		label.custom_minimum_size = Vector2(150, 40)
		
		label.add_child(button)
		label.size = Vector2(150, 40)
		answer_grid.add_child(label)

func _on_answer_button_pressed(button: Button):
	var correct = button.get_meta("correct")
	if not correct:
		var time = timer.time_left - 30;
		if time < 1:
			timer.timeout.emit()
		timer.start(time)
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


func _on_visibility_changed():
	StageManager.panel_visibility_changed.emit(null, visible)
	if !visible && timer:
		timer.stop()
		SceneChanger.resume_game(self)
