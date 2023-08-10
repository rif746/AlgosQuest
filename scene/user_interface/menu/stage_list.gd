extends Control
class_name StageMenu

var StageButton = preload("res://scene/user_interface/entity/button/stage_button.tscn")
@onready var stage_container = $Main/Bottom/BottomFlowContainer

func _ready():
	var materials = StageLoader.load_stage()
	for materi in materials:
		var button = StageButton.instantiate()
		button.set_text(materi.title)
		button.stage_id = materi.id
		stage_container.add_child(button)


func _on_back_pressed():
	SceneChanger.change_scene("res://scene/user_interface/menu/main_menu.tscn")
