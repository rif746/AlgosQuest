extends StaticBody2D
class_name Door

@onready var animated_sprite_2d = $AnimatedSprite2D

func open_door():
	collision_layer = 0
	animated_sprite_2d.play("open")
