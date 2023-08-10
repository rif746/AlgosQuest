extends CanvasLayer
class_name GameHUD

signal game_over()
signal paused()

@onready var player_label = %PlayerLabel
@onready var time_label = %TimeLabel
@onready var timer = $Timer

func _ready():
	player_label.text = Settings.userName

func _process(_delta):
	time_label.set_text(str(round(timer.time_left)))

func create_timer(time):
	timer.set_wait_time(time)
	timer.start()

func _on_pause_button_pressed():
	paused.emit()
	get_tree().paused = true

func _on_timer_timeout():
	timer.stop()
	game_over.emit()
