extends Area2D

signal game_clear()


func player_action():
	print("Exit Warp")
	game_clear.emit()
