extends Button
class_name StageButton

var stage_id: int:
	set(value):
		if !StageLoader.stage_unlocked(value):
			disabled = true
		else:
			is_unlocked = true
		stage_id = value
		StageLoader.stage_time = 300

var is_unlocked: bool = false

func _on_pressed():
	var gameplay = preload("res://scene/user_interface/gameui/gameplay_ui.tscn")
	SceneChanger.change_scene(gameplay)

