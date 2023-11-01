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

signal item_interaction(detected: bool)
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
	portal.game_clear.connect(_on_portal_game_clear)
	StageManager.exit_door_open.connect(_on_quest_cleared)
	StageManager.object_loaded.connect(_on_computer_window_closed)

func load_computer_window_content():	
	computer.install_computer(StageManager.stage_data)


func load_key():
	for mission in StageManager.object:
		var spawned = object_spawner.spawn(load("res://entity/object/flashdisk/flashdisk.tscn"))
		if spawned == null:
			break
		spawned.title = mission.chapter
		spawned.content = mission.text
		spawned.load_content()
		StageManager.object_count += 1
	StageManager.life_count = get_meta("life_count", 3)

func _on_item_interaction(detected: bool):
	item_interaction.emit(detected)


func _on_computer_window_closed(_loaded):
	entrance_door.open_door()
	load_key()


func _on_portal_game_clear():
	stage_clear.emit()

func _on_quest_cleared():
	exit_door.open_door()

