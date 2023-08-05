extends VBoxContainer

@onready var bgmLabel = $MarginContainer2/VBoxContainer/BGMVolumeContainer/SliderSplit/BGMLabel
@onready var bgmSlider = $MarginContainer2/VBoxContainer/BGMVolumeContainer/SliderSplit/BGMSlider
@onready var sfxLabel = $MarginContainer2/VBoxContainer/SFXVolumeContainer/SliderSplit/SFXLabel
@onready var sfxSlider = $MarginContainer2/VBoxContainer/SFXVolumeContainer/SliderSplit/SFXSlider
@onready var diffButton = $MarginContainer2/VBoxContainer/DifficultyContainer/DifficultyOption

func _ready():
	bgmLabel.text = "%s" % Settings.bgm
	bgmSlider.value = Settings.bgm
	sfxLabel.text = "%s" % Settings.sfx
	sfxSlider.value = Settings.sfx
	diffButton.add_item("EASY")
	diffButton.add_item("NORMAL")
	diffButton.add_item("HARD")
	diffButton.select(Settings.difficulty)

func _on_back_pressed():
	Settings.save_setting()
	SceneChanger.change_scene("res://scene/user_interface/menu/main_menu.tscn")


func _on_bgm_slider_value_changed(value):
	Settings.set_bgm(value)
	bgmLabel.text = "%s" % value


func _on_sfx_slider_value_changed(value):
	Settings.set_sfx(value)
	sfxLabel.text = "%s" % value


func _on_difficulty_option_item_selected(index):
	Settings.set_difficulty(index)
