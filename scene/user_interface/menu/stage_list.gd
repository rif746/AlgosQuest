extends Control

var Materi = preload("res://global/material_loader.gd")
var StageButton = preload("res://scene/user_interface/button/stage_button.tscn")
@onready var stage_container = $Main/Bottom/BottomFlowContainer

func _ready():
	var materials = Materi.new()
	materials = materials.load_material()
	for materi in materials:
		var button = StageButton.instantiate()
		button.set_text(materi.title)
		button.set_stage(materi.id)
		stage_container.add_child(button)


func _on_back_pressed():
	SceneChanger.change_scene("res://scene/user_interface/menu/main_menu.tscn")
