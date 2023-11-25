extends CharacterBody2D
class_name PlayerCharacter

const MAX_SPEED = 75

@export var use_light: bool = false:
	set(_toggle):
		use_light = _toggle
		point_light_2d.enabled = _toggle

@onready var sprite = $Sprite2D
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
@onready var point_light_2d = $PointLight2D
@onready var camera: Camera2D = $Camera2D

var item_function: Callable
var item_list: Array
var input_direction: Vector2 = Vector2.ZERO
var interacted_with_item: bool = false

signal item_interaction(detected: bool)

func _ready():
	player_movement()
	StageManager.panel_visibility_changed.connect(_on_panel_visibility_changed)

func _process(_delta):
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	if (Input.is_action_just_pressed("ui_accept")) && item_function.is_valid():
		item_function.call()
	
	if !interacted_with_item:
		player_movement()
		velocity = input_direction * (MAX_SPEED)
		move_and_slide()


func set_camera_limit(top_left: Vector2, bottom_right: Vector2):
	camera.limit_top = int(top_left.y)
	camera.limit_left = int(top_left.x)
	camera.limit_bottom = int(bottom_right.y)
	camera.limit_right = int(bottom_right.x)


func player_movement():
	if velocity != Vector2.ZERO:
		animation_tree.set("parameters/conditions/idle", false)
		animation_tree.set("parameters/conditions/is_walking", true) 
	else:
		animation_tree.set("parameters/conditions/idle", true)
		animation_tree.set("parameters/conditions/is_walking", false) 
	
	if input_direction != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_direction)
		animation_tree.set("parameters/Walk/blend_position", input_direction)


func _on_item_detector_body_entered(body):
	if body.has_method("interaction"):
		item_function = body.interaction
		item_interaction.emit(true)

func _on_item_detector_body_exited(_body):
	item_function = func(): pass
	item_interaction.emit(false)


func _on_panel_visibility_changed(_id, visibility):
	interacted_with_item = visibility
