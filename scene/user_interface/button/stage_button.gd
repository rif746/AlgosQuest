extends Button

var stage_id: int;

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

# set stage id
# @param int stage_id
func set_stage(id: int):
	stage_id = id


func _on_pressed():
	randomize()
	var stage = STAGE.pick_random()
	stage = stage.replace("{diff}", STAGE_DIFFICULTY[Settings.difficulty])
	SceneChanger.change_scene(stage)

