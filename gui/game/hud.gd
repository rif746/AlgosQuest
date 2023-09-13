extends Control
class_name HUDControl

@onready var player_name_label = %PlayerNameLabel
@onready var timer_label = %TimerLabel
@onready var stage_timer = $StageTimer
@onready var pause_ui = $HUDCanvas/PauseUI
@onready var game_over_ui = $HUDCanvas/GameOverUI
@onready var game_clear_ui = $HUDCanvas/GameClearUI
@onready var life_texture = %LifeTexture
@onready var virtual_controller = %VirtualController
@onready var quest_progress_count = %QuestProgressCount

var stage_data: Dictionary:
	set(new_stage_data):
		quest = new_stage_data.mission
		life_count = quest.size()
		is_tutorial = new_stage_data.is_tutorial
		new_stage_data.erase('mission')
		new_stage_data.erase('is_tutorial')
		stage_data = new_stage_data
var quest: Array
var is_tutorial: bool = false
var current_stage: World
var quest_count: int
var life_count: int

const TUTORIAL_WORLD = "res://world/tutorial.tscn"
const STAGE_WORLD = [
	"res://world/easy/stage_1.tscn"
]

func _ready():
	player_name_label.set_text(Settings.userName)
	BGMAudioStream.stop()
	load_stage()


func _process(_delta):
	var minutes = stage_timer.time_left / 60;
	var seconds = fmod(stage_timer.time_left, 60)
	timer_label.set_text(str("%02d:%02d" % [minutes, seconds]))


func load_stage():
	randomize()
	
	# unload stage if game restarted
	if (current_stage is World):
		current_stage.queue_free()
	
	if (is_tutorial):
		current_stage = load(TUTORIAL_WORLD).instantiate()
	else:
		var stage = STAGE_WORLD.pick_random()
		current_stage = load(stage).instantiate()
	
	# setup stage data for interaction
	current_stage.stage_data = stage_data
	current_stage.quest_available = quest
	current_stage.item_interaction.connect(virtual_controller.toggle_interact_button)
	current_stage.stage_clear.connect(_on_stage_cleared)
	current_stage.quest_loaded.connect(_on_load_quest)
	current_stage.quest_cleared.connect(_on_quest_cleared)
	
	add_child(current_stage)

	life_texture.hide()

	# start game timer
	var timer = current_stage.stage_time
	stage_timer.set_wait_time(timer)
	stage_timer.start()

func _on_load_quest(new_quest_count):
	life_count = new_quest_count
	quest_count = new_quest_count
	# if (life_count < 3 && quest.size() > 3):
	# 	life_count = 3
	
	# load life texture
	life_texture.show()
	quest_progress_count.set_text(str("Found 0 of %d Object" % quest_count))
	life_texture.custom_minimum_size = Vector2(16 * life_count, 0)

func _on_stage_cleared():
	SaveLoad.stage_clear(stage_data.id)
	GameSystem.pause_game(game_clear_ui)

func _on_quest_cleared(quest_cleared_count: int ,is_true: bool):
	quest_progress_count.set_text(str("Found %d of %d Object" % [quest_cleared_count, quest_count]))
	if !is_true:
		life_count -= 1
		life_texture.custom_minimum_size = Vector2(16 * life_count, 0)

func _on_stage_timer_timeout():
	GameSystem.pause_game(game_over_ui)


func _on_pause_button_pressed():
	GameSystem.pause_game(pause_ui)


func _on_game_over_ui_restart_game():
	load_stage()
