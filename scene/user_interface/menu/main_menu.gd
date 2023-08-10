extends Control
class_name MainMenu


func _on_quit_pressed():
	get_tree().quit()


func _on_start_pressed():
	SceneChanger.change_scene("res://scene/user_interface/menu/stage_list.tscn")


func _on_options_pressed():
	SceneChanger.change_scene("res://scene/user_interface/menu/options_menu.tscn")
