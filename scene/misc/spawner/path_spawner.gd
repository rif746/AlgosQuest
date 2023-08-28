extends Path2D
class_name PathSpawner

func random_spawn(scene: PackedScene):
	randomize()
	$Location.progress_ratio = randf()
	var instantiated_scene = scene.instantiate()
	instantiated_scene.position = $Location.position
	get_parent().add_child(instantiated_scene)
	return instantiated_scene
