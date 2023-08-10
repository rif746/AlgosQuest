extends Node

const MATERIAL_FILE = "res://assets/data/material.json"

var stage_id
var stage_time

static func load_stage():
	var material_data = FileAccess.get_file_as_string(MATERIAL_FILE)
	material_data = JSON.parse_string(material_data)
	return material_data.material

func load_stage_by_id():
	var material_data = FileAccess.get_file_as_string(MATERIAL_FILE)
	material_data = JSON.parse_string(material_data)
	#return material_data.material.find()

func stage_unlocked(id):
	var progress = SaveLoad.progress.get(Settings.get_current_difficulty())
	return progress.has(str(id - 1))
