extends Node

enum Difficulty {
	EASY,
	NORMAL,
	HARD
}

const SETTINGS_PATH = "user://settings.json"

var difficulty: Difficulty = Difficulty.EASY
var bgm = 100
var sfx = 100
var userName = "Player"

func _ready():
	load_setting()

func set_bgm(num: int):
	bgm = num

func set_sfx(num: int):
	sfx = num

func set_difficulty(difficult: Difficulty):
	difficulty = difficult

func set_player_name(playerName: String):
	userName = playerName

func load_setting():
	if(FileAccess.file_exists(SETTINGS_PATH)):
		var save_data = FileAccess.get_file_as_string(SETTINGS_PATH)
		save_data = JSON.parse_string(save_data)
		bgm = save_data.bgm
		sfx = save_data.sfx
		userName = save_data.userName
		difficulty = save_data.difficulty

func save_setting():
	var save_data = FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
	var data = {
		"bgm": bgm,
		"sfx": sfx,
		"userName": userName,
		"difficulty": difficulty,
	}
	save_data.store_string(JSON.stringify(data))
