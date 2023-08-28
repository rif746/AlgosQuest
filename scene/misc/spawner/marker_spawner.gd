extends Node2D

func random_spawn(scene: PackedScene):
	var instantiated_scene;
	if get_children() != []:
		var mark = get_children().pick_random()
		if mark is PathSpawner:
			instantiated_scene = mark.random_spawn(scene)
		else:
			instantiated_scene = scene.instantiate()
			instantiated_scene.position = mark.position

		mark.queue_free()
		remove_child(mark)
		if instantiated_scene.get_parent() != self:
			add_child(instantiated_scene)

	return instantiated_scene
