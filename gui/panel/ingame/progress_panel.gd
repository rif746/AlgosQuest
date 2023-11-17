extends Control
class_name ProgressPanel

@onready var list_container = %ListContainer
@onready var btn_group = ButtonGroup.new()

signal learn(title, content)

func _ready():
	StageManager.object_found.connect(_on_object_found)
	btn_group.pressed.connect(_on_btn_group_pressed)
	for content in StageManager.object:
		var btn = Button.new()
		btn.set_text(content.chapter)
		btn.disabled = true
		btn.flat = true
		btn.toggle_mode = true
		btn.mouse_filter = btn.MOUSE_FILTER_IGNORE
		btn.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		btn.set_meta("chapter", content.chapter)
		btn.set_meta("text", content.text)
		btn.button_group = btn_group
		list_container.add_child(btn)


func _on_btn_group_pressed(button):
	var title = button.get_meta("chapter")
	var content = button.get_meta("text")
	learn.emit(title, content)


func _on_object_found(chapter):
	for button in btn_group.get_buttons():
		var btn_chapter = button.get_meta('chapter')
		if chapter == btn_chapter:
			button.mouse_filter = button.MOUSE_FILTER_PASS
			button.disabled = false


func _on_close_button_pressed():
	hide()


func _on_visibility_changed():
	StageManager.panel_visibility_changed.emit(null, visible)
