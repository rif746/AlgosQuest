extends Node
class_name MainInterface

@onready var user_label = %UserLabel
@onready var timer_label = %TimerLabel
@onready var stage_timer = $StageTimer

var stage_data: Dictionary:
	set(new_stage_data):
		mission = new_stage_data.mission
		new_stage_data.erase('mission')
		stage_data = new_stage_data
var mission: Array

const STAGE_WORLD = [
	"res://scene/stage/easy/stage_1.tscn"
]

func _ready():
	randomize()
	var stage = STAGE_WORLD.pick_random()
	stage = load(stage).instantiate()
	
	stage.stage_data = stage_data
	stage.mission_available = mission
	
	add_child(stage)
	var timer = stage.get_meta("timer", 240)
	stage_timer.set_wait_time(timer)



func _on_stage_timer_timeout():
	get_tree().set_paused(true)
