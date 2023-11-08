extends Control
class_name HUDControl

@onready var player_name_label = %PlayerNameLabel
@onready var timer_label = %TimerLabel
@onready var stage_timer = $StageTimer
@onready var pause_ui = $HUDCanvas/PauseUI
@onready var game_over_ui = $HUDCanvas/GameOverUI
@onready var game_clear_ui = $HUDCanvas/GameClearUI
@onready var progress_panel = $HUDCanvas/ProgressPanel
@onready var virtual_controller = %VirtualController
@onready var learning_panel = %LearningPanel

var current_stage: World

const TUTORIAL_WORLD = "res://world/tutorial.tscn"

func _ready():
	player_name_label.set_text(Settings.userName)
	BGMAudioStream.stop()
	load_stage()


func _process(_delta):
	var minutes = stage_timer.time_left / 60;
	var seconds = fmod(stage_timer.time_left, 60)
	timer_label.set_text(str("%02d:%02d" % [minutes, seconds]))

	if (Input.is_action_just_pressed("ui_select") && StageManager.object_ready):
		progress_panel.visible = !progress_panel.visible;


func load_stage():
	randomize()
	
	# unload stage if game restarted
	if (current_stage is World):
		current_stage.queue_free()
	
	if (StageManager.is_tutorial_stage):
		current_stage = load(TUTORIAL_WORLD).instantiate()
	else:
		var stage = get_random_world_file()
		current_stage = load(stage).instantiate()
	
	current_stage.item_interaction.connect(virtual_controller.toggle_interact_button)
	current_stage.stage_clear.connect(_on_stage_cleared)
	if !StageManager.object_loaded.is_connected(virtual_controller.toggle_progress_button):
		StageManager.object_loaded.connect(virtual_controller.toggle_progress_button)
	if !StageManager.game_over.is_connected(_on_timeout):
		StageManager.game_over.connect(_on_timeout)
	if !StageManager.pause_game.is_connected(_on_pause):
		StageManager.pause_game.connect(_on_pause)
	
	add_child(current_stage)

	# start game timer
	stage_timer.set_wait_time(current_stage.stage_time)
	stage_timer.start()


func get_random_world_file():
	var files = []
	var dir = DirAccess.open("res://world/main/")
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append("res://world/main/%s" % file)

	dir.list_dir_end()

	return files.pick_random()


func _on_stage_cleared():
	SaveLoad.stage_clear(StageManager.stage_data.id)
	StageLoader.stage_unlocked(StageManager.stage_data.id)
	StageLoader.stage_cleared(StageManager.stage_data.id)
	SceneChanger.pause_game(game_clear_ui)
	

func _on_timeout():
	SceneChanger.pause_game(game_over_ui)


func _on_pause(node = pause_ui):
	SceneChanger.pause_game(node)


func _on_restart_game():
	load_stage()


func _on_learn(title, content):
	learning_panel.show()
	learning_panel.install_window(title, content)
