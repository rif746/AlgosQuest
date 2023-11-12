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
@onready var tutorial_panel = $HUDCanvas/TutorialPanel
@onready var information_panel = %InformationPanel
@onready var progress_label = %ProgressLabel
@onready var progress_separator = %ProgressSeparator

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
	if !StageManager.object_loaded.is_connected(_on_object_loaded):
		StageManager.object_loaded.connect(_on_object_loaded)
	if !StageManager.game_over.is_connected(_on_timeout):
		StageManager.game_over.connect(_on_timeout)
	if !StageManager.pause_game.is_connected(_on_pause):
		StageManager.pause_game.connect(_on_pause)
	if !StageManager.toggle_info_panel.is_connected(_on_learn):
		StageManager.toggle_info_panel.connect(_on_learn)
	if !StageManager.update_object_information.is_connected(_on_update_object_information):
		StageManager.update_object_information.connect(_on_update_object_information)
	
	add_child(current_stage)

	tutorial_panel.visible = StageManager.is_tutorial_stage
	
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
	
	return files.pick_random().trim_suffix(".remap")


func _on_stage_cleared():
	SaveLoad.stage_clear(StageManager.stage_data.id)
	StageLoader.stage_unlocked(StageManager.stage_data.id)
	StageLoader.stage_cleared(StageManager.stage_data.id)
	SceneChanger.pause_game(game_clear_ui)
	

func _on_timeout():
	pause_ui.hide();
	game_clear_ui.hide();
	progress_panel.hide();
	information_panel.hide();
	SceneChanger.pause_game(game_over_ui)


func _on_pause(node = pause_ui):
	SceneChanger.pause_game(node)


func _on_restart_game():
	load_stage()


func _on_learn(title, content):
	information_panel.visible = !information_panel.visible
	information_panel.set_information(title, content)


func _on_object_loaded():
	virtual_controller.toggle_progress_button(true)


func _on_update_object_information(found: int, available: int):
	progress_separator.show()
	progress_label.show()
	progress_label.set_text("Object %d of %d" % [found, available])
