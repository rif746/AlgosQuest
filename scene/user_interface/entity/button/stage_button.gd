extends Button
class_name StageButton

var stage: Dictionary:
	set(value):
		if !StageLoader.stage_unlocked(value.id):
			disabled = true
		if StageLoader.stage_cleared(value.id):
			is_cleared = true
		stage = value
		StageLoader.stage_time = 300

var is_cleared: bool = false
