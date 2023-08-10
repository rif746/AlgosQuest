extends CanvasLayer
class_name PauseMenu



func _on_back_to_menu_pressed():
	get_tree().paused = false
	SceneChanger.change_scene("res://scene/user_interface/menu/stage_list.tscn")


func _on_resume_pressed():
	get_tree().paused = false
	hide()
