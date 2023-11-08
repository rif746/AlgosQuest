extends Node

# save file path
const SAVE_PATH = "user://cleared_progress.dat"

# encryption salt
const SALT = "7fa0c6c3d7d987be22f16c12a480ffad"

# user ingame progress
var progress: Dictionary


func _ready():
	progress = load_save_data()


# save data when stage cleared
func stage_clear(stage_id):
	var currentDifficulty = Settings.get_current_difficulty()
	
	# dont save if stage has cleared before
	if(progress.get(currentDifficulty).has(str(stage_id))):
		return
	
	var save_data = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.WRITE, SALT)
	
	progress.get(currentDifficulty).append(str(stage_id))
	var data = {
		"progress": progress
	}
	
	save_data.store_var(data)

# load saved data from binary file
func load_save_data() -> Dictionary:
	var load_data = null
	if(FileAccess.file_exists(SAVE_PATH)):
		load_data = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.READ, SALT)
		load_data = load_data.get_var()
	
	if load_data != null:
		return load_data.progress
	else:
		return {
			"easy": ["0"],
			"normal": [],
			"hard": [],
		}
