extends Control
class_name MainMenu

@onready var about_panel = %AboutPanel
@onready var options_panel = %OptionsPanel

func _on_exit_button_pressed():
	SceneChanger.exit_panel.show()


func _on_play_button_pressed():
	SceneChanger.change_scene("res://gui/menu/stage_list.tscn")


func _on_option_button_pressed():
	options_panel.show()


func _on_about_button_pressed():
	about_panel.show()
