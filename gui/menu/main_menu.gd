extends Control
class_name MainMenu

@onready var about_panel = $AboutPanel

func _on_exit_button_pressed():
	GameSystem.exit_panel.show()


func _on_play_button_pressed():
	SceneChanger.change_scene("res://gui/menu/stage_list.tscn")


func _on_option_button_pressed():
	SceneChanger.change_scene("res://gui/menu/options_menu.tscn")


func _on_about_button_pressed():
	about_panel.show()
