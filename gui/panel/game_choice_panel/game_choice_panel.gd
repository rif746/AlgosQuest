extends Control

@export var learning_panel: Control

@onready var material_label = %MaterialLabel


var stage_data: Dictionary 

func open_window(new_stage_data):
	stage_data = new_stage_data
	material_label.set_text(new_stage_data.title)
	show()


func _on_close_button_pressed():
	hide()
	material_label.set_text("")


func _on_change_scene(node: Node):
	node.stage_data = stage_data


func _on_play_button_pressed():
	SceneChanger.change_scene_with_callback("res://gui/game/hud.tscn", _on_change_scene.bind())


func _on_read_button_pressed():
	learning_panel.install_window(stage_data.title, stage_data.content);
	learning_panel.show()
