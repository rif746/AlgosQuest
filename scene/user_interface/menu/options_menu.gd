extends Control
class_name OptionsMenu

@onready var player_name = %PlayerName
@onready var bgm_slider = %BGMSlider
@onready var sfx_slider = %SFXSlider
@onready var difficulty_option = %DifficultyOption


func _ready():
	player_name.set_text(Settings.userName)
	bgm_slider.set_value(Settings.bgm)
	sfx_slider.set_value(Settings.sfx)
	difficulty_option.select(Settings.difficulty)

func _on_back_pressed():
	Settings.save_setting()
	SceneChanger.change_scene("res://scene/user_interface/menu/main_menu.tscn")


func _on_bgm_slider_value_changed(value):
	Settings.set_bgm(value)


func _on_sfx_slider_value_changed(value):
	Settings.set_sfx(value)


func _on_difficulty_option_item_selected(index):
	Settings.set_difficulty(index)


func _on_text_edit_text_changed():
	Settings.set_player_name(player_name.text)
