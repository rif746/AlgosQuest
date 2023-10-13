extends Control

@onready var stage_container = $Panel/VBoxContainer/ScrollContainer/StageContainer
@onready var game_choice_panel = $GameChoicePanel

func _ready():
	var button_group = ButtonGroup.new()
	button_group.pressed.connect(_on_stage_button_pressed)
	for stage in StageLoader.stage:
		# setup new button
		var button = Button.new()
		button.text = str(stage.id)
		button.custom_minimum_size = Vector2(100, 100)
		button.button_group = button_group
		button.toggle_mode = true
		
		# add meta to button
		button.set_meta("stage_data", stage)
		button.set_meta("is_unlocked", StageLoader.stage_unlocked(stage.id))
		button.set_meta("is_cleared", StageLoader.stage_cleared(stage.id))
		
		# disable button when stage lockeds
		if !StageLoader.stage_unlocked(stage.id):
			button.disabled = true
		
		# add button to container
		stage_container.add_child(button)
	
	$sfx_control.install_sounds(stage_container)


func _on_stage_button_pressed(btn):
	var stage_data = btn.get_meta("stage_data", {})
	var is_unlocked = btn.get_meta("is_unlocked", false)
	var is_cleared = btn.get_meta("is_cleared", false)
	
	if not is_cleared:
		StageManager.stage_data = stage_data
		SceneChanger.change_scene("res://gui/game/hud.tscn")
	else:
		game_choice_panel.open_window(stage_data)
	btn.button_pressed = false

func _on_back_button_pressed():
	SceneChanger.change_scene("res://gui/menu/main_menu.tscn")

