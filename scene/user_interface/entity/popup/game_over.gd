extends CanvasLayer
class_name GameOverUI

signal restart_game()

func _on_back_to_menu_pressed():
	SceneChanger.change_scene("res://scene/user_interface/menu/stage_list.tscn")


func _on_try_again_pressed():
	hide()
	restart_game.emit()
