extends CharacterBody2D

const MAX_SPEED = 100

@onready var sprite = $Sprite2D
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer

var item_function: Callable
var item_list: Array
var input_direction: Vector2 = Vector2.ZERO

signal item_detected(area: Area2D)
signal item_undetected(area: Area2D)

func _ready():
	player_movement()

func _process(_delta):
	player_movement()

func _physics_process(delta):
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	if (Input.is_action_just_pressed("pick_up")) && item_function.is_valid():
		item_function.call()
	
	velocity = input_direction * (MAX_SPEED * delta)
	
	move_and_collide(velocity)


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


func _on_player_detection_area_entered(_area):
	if _area.get_parent().has_method("player_action"):
		item_function = _area.get_parent().player_action
	item_detected.emit(_area)


func _on_player_detection_area_exited(_area):
	item_function = func(): pass
	item_undetected.emit(_area)
