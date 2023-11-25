extends CanvasLayer

@onready var save_button = %SaveButton

func _ready():
	hide()
	if Settings.userName == null:
		show()

func _on_player_name_text_changed(new_text: String):
	Settings.set_player_name(new_text)
	if new_text.is_empty():
		save_button.disabled = true
	else:
		save_button.disabled = false

func _on_save_button_pressed():
	Settings.save_setting()
	hide()
