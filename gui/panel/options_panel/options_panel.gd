extends Control
class_name OptionsMenu

@onready var bgm_slider = %BGMSlider
@onready var sfx_slider = %SFXSlider
@onready var option_panel = %OptionPanel

var height: int = 0

func _ready():
	bgm_slider.set_value(Settings.bgm)
	sfx_slider.set_value(Settings.sfx)

func _process(_delta):
	if DisplayServer.has_feature(DisplayServer.FEATURE_VIRTUAL_KEYBOARD):
		var keyboard_height = DisplayServer.virtual_keyboard_get_height()
		if keyboard_height > 1 && height == 0:
				height = option_panel.size.y
				option_panel.size.y /= 2.5
		elif keyboard_height <= 1 && height > 0:
			option_panel.size.y = height
			height = 0

func _on_save_button_pressed():
	Settings.save_setting()
	hide()


func _on_bgm_slider_value_changed(value):
	Settings.set_bgm(value)


func _on_sfx_slider_value_changed(value):
	Settings.set_sfx(value)


