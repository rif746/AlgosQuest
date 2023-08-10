extends Node2D
class_name GamePlayUI

@onready var game_hud = $GameHUD
@onready var game_over_ui = $GameOverUI
@onready var pause_menu = $PauseMenu

const STAGE = [
	"res://scene/stage/{diff}/stage_1.tscn",
	"res://scene/stage/{diff}/stage_2.tscn",
	"res://scene/stage/{diff}/stage_3.tscn"
]

const STAGE_DIFFICULTY = [
	"easy",
	"normal",
	"hard"
] 

var stage;

func _ready():
	start_game()

func start_game():
	randomize()
	if ! (stage is String) && stage != null:
		print(stage)
		stage.queue_free()
	stage = STAGE.pick_random()
	stage = stage.replace("{diff}", STAGE_DIFFICULTY[Settings.difficulty])
	stage = load(stage).instantiate()
	add_child(stage)
	game_hud.create_timer(4)

func _on_game_over_ui_restart_game():
	start_game()

func _on_game_hud_game_over():
	game_over_ui.show()

func _on_game_hud_paused():
	pause_menu.show()
