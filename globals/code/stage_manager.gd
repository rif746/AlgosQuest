extends Node

signal life_count_changed(count: int)
signal game_over()
signal can_answer_question()
signal pause_game(panel: Control)
signal exit_door_open()
signal update_object_information(object_found: int, object_available: int)
signal object_loaded()
signal object_found(String)
signal toggle_info_panel(title: String, content: String)
signal panel_visibility_changed(String, bool)
signal change_quest_time(time: int)

var stage_data: StageData:
	set(new_stage_data):
		object = new_stage_data.content
		question = new_stage_data.quest
		is_tutorial_stage = new_stage_data.is_tutorial
		stage_data = new_stage_data

var object: Array[MaterialContent]
var question: Array[Quest]
var is_tutorial_stage: bool

var life_count: int:
	set(count):
		life_count_changed.emit(count)
		life_count = count
var object_ready: bool:
	set(loaded):
		object_loaded.emit()
		object_ready = loaded
var object_count: int:
	set(count):
		update_object_information.emit(object_found_count, count)
		object_count = count

var object_found_count: int:
	set(count):
		if(count == object_count):
			can_answer_question.emit()
		update_object_information.emit(count, object_count)
		object_found_count = count

var question_answered: Array[String]
var question_time: int:
	set(time):
		change_quest_time.emit(time)
		question_time = time
var game_time: int
var score: int

func clear():
	stage_data = StageData.new()
	object = []
	question = []
	is_tutorial_stage = false
	question_answered = []
	question_time = 0
	object_found_count = 0
	object_count = 0
	object_ready = false
	life_count = 0
	game_time = 0
	score = 0

func retry():
	question_answered = []
	question_time = 0
	object_found_count = 0
	object_count = 0
	object_ready = false
	life_count = 0
	game_time = 0
	score = 0
