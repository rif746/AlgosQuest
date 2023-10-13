extends Control

@onready var title = %Title
@onready var list_container = %ListContainer

signal close_window()

func install_rule(_title: String, rules: Array[String]):
		title.text = _title
		var num = 1
		for rule in rules:
			var label = Label.new()
			label.text = "%d. %s" % [num, rule]
			label.label_settings = load("res://assets/resource/theme/label_settings/content_small.tres")
			label.autowrap_mode = TextServer.AUTOWRAP_WORD
			list_container.add_child(label)
			num += 1


func _on_close_button_pressed():
	visible = false
