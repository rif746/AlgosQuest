extends Node

const SAVE_PATH = "user://cleared_progress.dat"
var progress: Dictionary
	
func _ready():
	progress = _load_state()

func stage_clear(stage_id):
	var currentDifficulty = Settings.get_current_difficulty()
	
	if(progress.get(currentDifficulty).has(str(stage_id))):
		return
	
	var save_data = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	progress.get(currentDifficulty).append(str(stage_id))
	var data = {
		"progress": progress
	}
	
	save_data.store_string(JSON.stringify(data))

func _load_state() -> Dictionary:
	if(FileAccess.file_exists(SAVE_PATH)):
		var load_data = FileAccess.get_file_as_string(SAVE_PATH)
		load_data = JSON.parse_string(load_data)
		return load_data.progress
	return {
		"easy": ["0"],
		"normal": [],
		"hard": [],
	}

