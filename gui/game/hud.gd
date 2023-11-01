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
	StageManager.object_loaded.connect(virtual_controller.toggle_progress_button)
	StageManager.game_over.connect(_on_stage_timer_timeout)
	
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
			files.append(file)

	dir.list_dir_end()

	return files.pick_random()


func _on_stage_cleared():
	SaveLoad.stage_clear(StageManager.stage_data.id)
	GameSystem.pause_game(game_clear_ui)
	

func _on_stage_timer_timeout():
	GameSystem.pause_game(game_over_ui)


func _on_pause_button_pressed():
	GameSystem.pause_game(pause_ui)


func _on_game_over_ui_restart_game():
	load_stage()


func _on_progress_panel_learn(title, content):
	learning_panel.show()
	learning_panel.install_window(title, content)
