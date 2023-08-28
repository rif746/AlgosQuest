extends CanvasLayer

var mission_id: int
@onready var instruction_label = %InstructionLabel
@onready var grid_container = $Panel/Margin1/MarginContainer/Panel/GridContainer

signal close_window()

func _ready():
	get_parent().load_window.connect(_on_load_window)

func _on_answer_group_pressed(button):
	get_tree().paused = false
	visible = false
	print(button.get_meta("is_true"))
	close_window.emit()

func _on_load_window(_id, _instruction, _answer: Array):
	mission_id = _id
	instruction_label.text = _instruction
	var button_group = preload("res://assets/resources/stage_group.tres")
	button_group.pressed.connect(_on_answer_group_pressed)
	for answer in _answer:
		var button = Button.new()
		button.set_text(answer.text)
		button.button_group = button_group
		if(answer.is_true):
			button.set_meta("is_true", true)
		grid_container.add_child(button)
