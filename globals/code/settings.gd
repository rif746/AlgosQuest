extends Node

enum Difficulty {
	EASY,
	NORMAL,
	HARD
}

const DIFFICULTY_STRING = [
	"easy",
	"normal",
	"hard",
]

# settings file path
const SETTINGS_PATH = "user://settings.dat"

# game difficulty (default: EASY)
var difficulty: Difficulty = Difficulty.EASY

# volume
var bgm = 100
var sfx = 100

# player name
var userName = "Player"

func _ready():
	load_setting()

func set_bgm(num: float):
	bgm = num
	var bus_index = AudioServer.get_bus_index("BGM")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(num))

func set_sfx(num: float):
	sfx = num
	var bus_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(num))

func set_difficulty(difficult: Difficulty):
	difficulty = difficult

func set_player_name(playerName: String):
	userName = playerName


# get current difficulty string
func get_current_difficulty():
	return DIFFICULTY_STRING[difficulty]


# get next difficulty string
func get_next_difficulty():
	if (difficulty + 1) < DIFFICULTY_STRING.size():
		return DIFFICULTY_STRING[difficulty + 1]
	return DIFFICULTY_STRING[difficulty]

# load saved settings from binary file
func load_setting():
	if(FileAccess.file_exists(SETTINGS_PATH)):
		var save_data = FileAccess.open(SETTINGS_PATH, FileAccess.READ)
		save_data = save_data.get_var()
		set_bgm(save_data.bgm)
		set_sfx(save_data.sfx)
		set_player_name(save_data.userName)
		set_difficulty(save_data.difficulty)

# save settings to binary file
func save_setting():
	var save_data = FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
	var data = {
		"bgm": bgm,
		"sfx": sfx,
		"userName": userName,
		"difficulty": difficulty,
	}
	
	save_data.store_var(data)
