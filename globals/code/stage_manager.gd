extends Node

signal life_count_changed(count: int)
signal object_count_changed(count: int, total: int)
signal object_found_count_changed(count: int, total: int)


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
var object_count: int:
	set(count):
		object_count_changed.emit(0, count)
		object_count = count
var object_found_count: int:
	set(count):
		object_found_count_changed.emit(count, object_count)
		object_found_count = count

var question_correct: int;
var question_incorrect: int;
var score: int;

