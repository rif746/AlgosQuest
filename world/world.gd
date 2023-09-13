extends Node
class_name World

@export var character: PackedScene
@export var character_spawner: PathSpawner
@export var object_spawner: BatchSpawner
@export var entrance_door: Door
@export var exit_door: Door
@export var computer: Computer
@export var portal: Portal
@export var use_light: bool
@export var stage_time: int
@export var top_left_camera_limit: Marker2D
@export var bottom_right_camera_limit: Marker2D

var stage_data: Dictionary
var quest_available: Array
var quest_success: Array
var quest_fail: Array

signal item_interaction(detected: bool)
signal quest_cleared(is_true: bool)
signal quest_loaded(loaded: int)
signal stage_clear()

func _ready():
	load_computer_window_content()
	initialize_object()
	pass


func initialize_object():
	var instantiated_character = character_spawner.spawn(character)
	var tl_camera_limit = top_left_camera_limit.position
	var br_camera_limit = bottom_right_camera_limit.position
	
	instantiated_character.use_light = use_light
	instantiated_character.set_camera_limit(tl_camera_limit, br_camera_limit)
	
	instantiated_character.item_interaction.connect(_on_item_interaction)
	computer.window_closed.connect(_on_computer_window_closed)
	portal.game_clear.connect(_on_portal_game_clear)

func load_computer_window_content():	
	computer.install_computer(stage_data.title, stage_data.content)


func load_key():
	var quest_loaded_count = 0;
	for mission in quest_available:
		var spawned = object_spawner.spawn(load("res://entity/object/flashdisk/flashdisk.tscn"))
		spawned.install_question.call(mission.question, mission.answer)
		spawned.answered.connect(_on_game_key_answered)
		if spawned:
			quest_loaded_count += 1
			spawned = null
			await get_tree().create_timer(.1).timeout
		quest_loaded.emit(quest_loaded_count)


func check_quest_clear():
	var quest_available_size = quest_available.size()
	var quest_success_size = quest_success.size()
	var quest_fail_size = quest_fail.size()
	if quest_available_size == (quest_fail_size + quest_success_size):
		exit_door.open_door()

func _on_item_interaction(detected: bool):
	item_interaction.emit(detected)


func _on_computer_window_closed():
	entrance_door.open_door()
	load_key()


func _on_portal_game_clear():
	stage_clear.emit()


func _on_game_key_answered(quest_id, is_true: bool):
	if is_true:
		quest_success.append(quest_id)
	else:
		quest_fail.append(quest_id)
	quest_cleared.emit(quest_success.size(), is_true)
	check_quest_clear()
