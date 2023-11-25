extends Path2D
class_name PathSpawner

@onready var path_follow = $PathFollow

# spawn object at random area following path
func spawn(scene: PackedScene):
	path_follow.progress_ratio = randf()
	var instantiated_scene = scene.instantiate()
	get_parent().add_child(instantiated_scene)
	instantiated_scene.global_position = path_follow.global_position
	return instantiated_scene
