extends StaticBody2D
class_name Portal

signal game_clear()

func interaction():
	game_clear.emit()
