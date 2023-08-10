extends Control
class_name StageMenu

@onready var stage_container = %StageContainer
@onready var stage_title = %StageTitle
@onready var stage_description = %StageDescription
@onready var read_button = %ReadButton
@onready var play_button = %PlayButton

var stage_id: int

func _ready():
	var materials = StageLoader.load_stage()
	var button_group = preload("res://scene/user_interface/entity/button/stage_group.tres")
	button_group.pressed.connect(_on_stage_group_pressed)
	for materi in materials:
		var button = StageButton.new()
		button.set_text(materi.title)
		button.toggle_mode = true
		button.button_group = button_group
		button.stage = materi
		stage_container.add_child(button)

func _on_stage_group_pressed(button):
	stage_id = button.stage.id
	stage_title.set_text(button.stage.title)
	stage_description.set_text(button.stage.description)
	play_button.disabled = false
	if button.is_cleared:
		read_button.disabled = false
	else:
		read_button.disabled = true
	
func _on_back_pressed():
	SceneChanger.change_scene("res://scene/user_interface/menu/main_menu.tscn")


func _on_play_button_pressed():
	StageLoader.stage_id = stage_id
	SceneChanger.change_scene("res://scene/user_interface/gameui/gameplay_ui.tscn")

