extends Control

@export var learning_panel: Control

@onready var material_label = %MaterialLabel


var stage_data: StageData

func open_window(new_stage_data: StageData):
	material_label.set_text(new_stage_data.title)
	StageManager.stage_data = new_stage_data
	show()


func _on_close_button_pressed():
	hide()
	material_label.set_text("")


func _on_play_button_pressed():
	SceneChanger.change_scene("res://gui/game/hud.tscn")


func _on_read_button_pressed():
	var title = StageManager.stage_data.title
	var content = ""
	
	for _content in StageManager.object:
		content += "[font size=18][b]%s[/b][/font]\n" % _content.chapter
		content += "[font size=14]%s[/font]\n\n" % _content.text
	
	learning_panel.set_information(title, content);
	learning_panel.show()
