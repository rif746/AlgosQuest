extends Node
class_name StageLoader

const STAGE_FILE = "res://assets/resource/json/stage_data.json"

func load_stage():
	var stage_data = FileAccess.get_file_as_string(STAGE_FILE)
	stage_data = JSON.parse_string(stage_data)
	return stage_data.stage

# check unlocked stage by difficulty
func stage_unlocked(stage_id):
	var progress = SaveLoad.progress.get(Settings.get_current_difficulty())
	
	# using stage_id - 1 because stage will unlcoked if stage_id - 1 is cleared 
	return progress.has(str(stage_id - 1))

# check cleared stage by difficulty
func stage_cleared(stage_id):
	var progress = SaveLoad.progress.get(Settings.get_current_difficulty())
	return progress.has(str(stage_id))
