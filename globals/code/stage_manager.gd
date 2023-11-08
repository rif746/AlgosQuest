extends Node

signal life_count_changed(count: int)
signal game_over()
signal can_answer_question()
signal pause_game(panel)
signal exit_door_open()
signal object_found(id)
signal object_loaded()
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
		object_loaded.emit(loaded)
		object_ready = loaded
var object_count: int
var object_found_count: int:
	set(count):
		if(count == object_count):
			can_answer_question.emit()
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
