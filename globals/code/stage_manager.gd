extends Node

signal life_count_changed(count: int)
signal game_over()
signal can_answer_question()
signal exit_door_open()
signal object_found(id)
signal object_loaded()

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

var question_correct: int
var question_incorrect: int
var question_time: int
var score: int

