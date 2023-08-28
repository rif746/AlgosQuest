extends AnimatedSprite2D

@onready var collision = $Collision
@onready var sfx = $SFX
@onready var collision_shape_2d = $Collision/CollisionShape2D

func open_door():
	sfx.stop()
	collision.collision_layer = 0
	collision.collision_mask = 0
	play("laser_off")
