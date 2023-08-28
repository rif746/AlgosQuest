extends Control
class_name StageMenu

@onready var stage_container = %StageContainer
@onready var stage_title = %StageTitle
@onready var stage_description = %StageDescription
@onready var read_button = %ReadButton
@onready var play_button = %PlayButton

var stage: Dictionary

func _ready():
	var stages = StageLoader.load_stage()
	var button_group = load("res://assets/resources/stage_group.tres")
	button_group.pressed.connect(_on_stage_group_pressed)
	for game_stage in stages:
		var button = Button.new()
		button.set_meta("stage", game_stage)
		
		# add meta cleared when stage is cleared
		if StageLoader.stage_cleared(game_stage.id):
			button.set_meta("cleared", true)
		
		# add meta unlocked when stage unlocked
		# disable button when stage locked
		if StageLoader.stage_unlocked(game_stage.id):
			button.set_meta("unlocked", true)
		else:
			button.set_disabled(true)
			
		button.set_text("Stage %s" % game_stage.id)
		button.set_toggle_mode(true)
		button.set_button_group(button_group)
		stage_container.add_child(button)
	$SFXControl._install_sounds(stage_container)

func _on_stage_group_pressed(button):
	var cleared = button.get_meta("cleared", false)
	var unlocked = button.get_meta("unlocked", false)

	stage = button.get_meta("stage")
	stage_title.set_text(stage.title)
	
	if cleared:
		read_button.set_disabled(false)
	else:
		read_button.set_disabled(true)
		
	if unlocked:
		play_button.set_disabled(false)
	else:
		play_button.set_disabled(true)
		

func _on_back_pressed():
	SceneChanger.change_scene("res://scene/user_interface/menu/main_menu.tscn")


func _on_play_button_pressed():
	SceneChanger.change_scene_with_callback("res://scene/user_interface/game_interface/main_interface.tscn", play_game.bind())


func _on_read_button_pressed():
	SceneChanger.change_scene("res://scene/user_interface/menu/stage_detail.tscn")


func play_game(scene: MainInterface):
	scene.stage_data = stage
