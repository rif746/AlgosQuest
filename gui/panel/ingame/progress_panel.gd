extends Control
class_name ProgressPanel

@onready var list_container = %ListContainer
@onready var btn_group = ButtonGroup.new()

signal learn(title, content)

func _ready():
	StageManager.object_found.connect(_on_object_found)
	btn_group.pressed.connect(_on_btn_group_pressed)
	for content in StageManager.object:
		var button = Button.new()
		button.set_meta("chapter", content.chapter)
		button.set_meta("text", content.text)
		button.disabled = true
		button.toggle_mode = true
		button.mouse_filter = button.MOUSE_FILTER_IGNORE
		button.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		button.button_group = btn_group
		button.show_behind_parent = true
		button.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		
		var label = Label.new()
		label.set_text(content.chapter)
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		label.size_flags_vertical = Control.SIZE_EXPAND_FILL
		label.set_custom_minimum_size(Vector2(0, 40))
		
		label.add_child(button)
		list_container.add_child(label)
	list_container.add_theme_constant_override("separation", 5)

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
