extends Node

var stage_data: StageData:
	set(new_stage_data):
		object = new_stage_data.content
		question = new_stage_data.quest
		is_tutorial_stage = new_stage_data.is_tutorial
		stage_data = new_stage_data

var object: Array[MaterialContent]
var question: Array[Quest]
var is_tutorial_stage: bool

var life_count: int
var object_count: int
var object_found_count: int
