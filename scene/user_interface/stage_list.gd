extends Control


func _ready():
	return


func _on_back_pressed():
	SceneChanger.change_scene("res://scene/user_interface/main_menu.tscn")
