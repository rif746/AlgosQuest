extends Control

signal restart_game()
signal open_option_panel()
signal open_guide_panel()

func _on_retry_button_pressed():
	SceneChanger.resume_game(self)
	StageManager.retry()
	restart_game.emit()


func _on_back_to_menu_button_pressed():
	SceneChanger.change_scene("res://gui/menu/stage_list.tscn")
	StageManager.clear()
	SceneChanger.resume_game(self)


func _on_resume_button_pressed():
	SceneChanger.resume_game(self)


func _on_options_button_pressed():
	open_option_panel.emit()


func _on_guide_button_pressed():
	open_guide_panel.emit()
