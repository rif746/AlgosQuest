extends Node2D

@onready var computer = $computer
@onready var game_clear_canvas: CanvasLayer
@onready var character = load("res://scene/entity/character/character.tscn")

var stage_data: Dictionary
var mission_available: Array
var mission_cleared: Array

func _ready():
	_spawn_character(character)
	computer.load_computer(stage_data.title, stage_data.instruction)


func _load_key():
	for mission in mission_available:
		var item = load("res://scene/entity/key_objects/flashdisk/flashdisk.tscn")
		item = _spawn_object(item);
		item.load_mission(mission.mission_id, mission.question, mission.answer)
		item.set_label(str(mission.question))
		item.pick_up.connect(_on_item_pick_up)

func _spawn_character(scene: PackedScene):
	randomize()
	var character_spawner = get_node("CharacterSpawner")
	return character_spawner.random_spawn(scene)


func _spawn_object(scene: PackedScene):
	randomize()
	var object_spawner = get_node("ObjectSpawner")
	return object_spawner.random_spawn(scene)


func _on_computer_window_closed():
	var door = get_node("EntranceDoor")
	door.open_door()
	_load_key()


func _on_item_pick_up(item_id):
	mission_cleared.append(item_id)
	if(mission_cleared.size() == stage_data.mission.size()):
		_on_open_exit_door()


func _on_open_exit_door():
	var door = get_node("ExitDoor")
	door.open_door()


func _on_exit_warp_game_clear():
	print("exit")
	game_clear_canvas.show()
