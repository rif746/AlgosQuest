extends CanvasLayer

func change_scene(scene):
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	
	if scene is PackedScene:
		get_tree().change_scene_to_packed(scene)
	else:
		get_tree().change_scene_to_file(scene)
		
	$AnimationPlayer.play_backwards("dissolve")


func change_scene_with_callback(scene, callback: Callable):
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	
	if scene is PackedScene:
		get_tree().current_scene.queue_free()
		scene = scene.instantiate()
		callback.callv(scene)
		get_tree().root.add_child(scene)		
		get_tree().set_current_scene(scene)
	else:
		get_tree().current_scene.queue_free()
		scene = load(scene).instantiate()
		callback.call(scene)
		get_tree().root.add_child(scene)		
		get_tree().set_current_scene(scene)
		
	$AnimationPlayer.play_backwards("dissolve")
