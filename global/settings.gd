extends Node

enum Difficulty {
	EASY,
	NORMAL,
	HARD
}

var difficulty = Difficulty
var bgm = 100
var sfx = 100

func set_bgm(num: int):
	bgm = num
	
func get_bgm():
	return bgm
	
func set_sfx(num: int):
	sfx = num
	
func get_sfx():
	return sfx
	
func set_difficulty(difficult = Difficulty):
	difficulty = difficult

func get_difficulty():
	return difficulty
