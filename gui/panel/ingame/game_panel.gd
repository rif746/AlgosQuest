extends Control

signal restart_game()

func _on_retry_button_pressed():
	GameSystem.resume_game(self)
	restart_game.emit()


func _on_back_to_menu_button_pressed():
	SceneChanger.change_scene("res://gui/menu/stage_list.tscn")
	GameSystem.resume_game(self)


func _on_resume_button_pressed():
	GameSystem.resume_game(self)
