extends Control



func _on_quit_pressed():
	get_tree().quit()


func _on_start_pressed():
	SceneChanger.change_scene("res://scene/user_interface/stage_list.tscn")


func _on_options_pressed():
	SceneChanger.change_scene("res://scene/user_interface/options_menu.tscn")
