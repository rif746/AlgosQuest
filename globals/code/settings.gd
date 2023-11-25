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

# encryption salt
const SALT = "43204e5dfe2ef7b2f1aa59b3d08ccef1"

# game difficulty (default: EASY)
var difficulty: Difficulty = Difficulty.EASY

# volume
var bgm = 100
var sfx = 100

# player name
var userName = null

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
		var settings = FileAccess.open_encrypted_with_pass(SETTINGS_PATH, FileAccess.READ, SALT)
		if settings != null:
			settings = settings.get_var()
			set_bgm(settings.bgm)
			set_sfx(settings.sfx)
			set_player_name(settings.userName)
			set_difficulty(settings.difficulty)

# save settings to binary file
func save_setting():
	var settings = FileAccess.open_encrypted_with_pass(SETTINGS_PATH, FileAccess.WRITE, SALT)
	var data = {
		"bgm": bgm,
		"sfx": sfx,
		"userName": userName,
		"difficulty": difficulty,
	}
	
	settings.store_var(data)
