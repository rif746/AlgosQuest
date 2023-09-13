extends Node2D
class_name BatchSpawner

# Randomly Spawn object
# remove selected children after object spawned
# only support with PathSpawner or Marker2D
func spawn(scene: PackedScene):
	assert(get_child_count() != 0, "no batch spawner child found")
	var instantiated_scene = scene
	if get_child_count() != 0:
		var mark = get_children().pick_random()
		
		if mark is PathSpawner:
			instantiated_scene = mark.spawn(scene)
		elif mark is Marker2D:
			instantiated_scene = scene.instantiate()
			add_child(instantiated_scene)
			instantiated_scene.position = mark.global_position
		else:
			return spawn(scene)
	
		remove_child(mark)
		mark.queue_free()
	return instantiated_scene
