extends Node
class_name World

@export var character: PackedScene
@export var tilemap: TileMap
@export var light: PointLight2D
@export var character_spawner: PathSpawner
@export var object_spawner: BatchSpawner
@export var entrance_door: Door
@export var exit_door: Door
@export var computer: Computer
@export var portal: Portal
@export var use_light: bool
@export var top_left_camera_limit: Marker2D
@export var bottom_right_camera_limit: Marker2D
@export var canvas_modulate: CanvasModulate
var instantiated_character: PlayerCharacter

signal item_interaction(detected: bool)
signal stage_clear()
signal toggle_hud(bool)

func _ready():
	var mapsize = tilemap.get_used_rect().size
	StageManager.game_time += (mapsize.x * mapsize.y) * 0.1
	light.enabled = false
	canvas_modulate.visible = use_light
	initialize_object()
	StageManager.object_loaded.connect(_on_object_loaded)
	StageManager.can_answer_question.connect(_on_can_answer_question)


func initialize_object():
	var tl_camera_limit = top_left_camera_limit.position
	var br_camera_limit = bottom_right_camera_limit.position
	
	instantiated_character = character_spawner.spawn(character)
	instantiated_character.use_light = use_light
	instantiated_character.set_camera_limit(tl_camera_limit, br_camera_limit)
	
	instantiated_character.item_interaction.connect(_on_item_interaction)
	portal.game_clear.connect(_on_portal_game_clear)
	StageManager.exit_door_open.connect(_on_quest_cleared)


func _on_object_loaded():
	if StageManager.object_count == 0:
		for mission in StageManager.object:
			var spawned = object_spawner.spawn(load("res://entity/object/flashdisk/flashdisk.tscn"))
			if spawned == null:
				break
			spawned.title = mission.chapter
			spawned.content = mission.text
			StageManager.object_count += 1
	StageManager.life_count = get_meta("life_count", 3)
	entrance_door.open_door()


func _on_item_interaction(detected: bool):
	item_interaction.emit(detected)


func _on_can_answer_question():
	instantiated_character.camera.global_position = light.global_position
	if use_light:
		light.enabled = true
	toggle_hud.emit(false)
	await get_tree().create_timer(3).timeout
	if use_light:
		light.enabled = false
	toggle_hud.emit(true)
	instantiated_character.camera.global_position = instantiated_character.global_position


func _on_portal_game_clear():
	stage_clear.emit()


func _on_quest_cleared():
	exit_door.open_door()

