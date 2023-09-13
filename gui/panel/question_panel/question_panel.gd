extends Control

@onready var content_label = %ContentLabel
@onready var answer_grid = %AnswerGrid
@onready var sfx_control = $sfx_control

signal answered(is_true: bool)

func install_question(question: String, answer: Array):
	content_label.clear()
	content_label.add_text(question)
	load_answer(answer)
	sfx_control.install_sounds(answer_grid)

func load_answer(answers: Array):
	var button_group = ButtonGroup.new()
	button_group.pressed.connect(_on_answer_button_pressed)
	
	for answer in answers:
		var button = Button.new()
		button.set_meta("is_true", answer.is_true)
		button.set_custom_minimum_size(Vector2(150, 40))
		button.set_text(answer.text)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.button_group = button_group
		button.toggle_mode = true
		
		answer_grid.add_child(button)

func _on_answer_button_pressed(button: Button):
	var is_true = button.get_meta("is_true", false)
	hide()
	answered.emit(is_true)
		

func _on_close_button_pressed():
	hide()
