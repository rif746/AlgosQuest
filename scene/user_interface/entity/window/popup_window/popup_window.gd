extends CanvasLayer

@onready var title_label = %TitleLabel
@onready var content_label = %ContentLabel

signal close_window()

func _ready():
	get_parent().load_window.connect(_on_load_window)

func _on_close_button_pressed():
	get_tree().paused = false
	visible = false
	close_window.emit()

func _on_load_window(_title, _materi):
	title_label.text = _title
	content_label.text = _materi
