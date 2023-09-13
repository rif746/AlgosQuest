extends CanvasLayer

var path_history: Array[String]

func change_scene(scene):
	$AnimationPlayer.play("dissolve")
	make_history_scene(scene)
	await $AnimationPlayer.animation_finished
	
	if scene is PackedScene:
		get_tree().change_scene_to_packed(scene)
	else:
		get_tree().change_scene_to_file(scene)
		
	$AnimationPlayer.play_backwards("dissolve")


func make_history_scene(scene):
	var current_scene_file_path = get_tree().current_scene.scene_file_path
	if (path_history.has(scene)):
		path_history.pop_back()
	elif current_scene_file_path != "res://gui/game/hud.tscn":
		path_history.append(current_scene_file_path)


func back_to_previous_scene():
	# if in main menu
	if path_history.size() == 0:
		return true
	
	var history_size = path_history.size()
	var scene_file = path_history[history_size - 1]
	change_scene(scene_file)


func change_scene_with_callback(scene, callback: Callable):
	$AnimationPlayer.play("dissolve")
	make_history_scene(scene)
	await $AnimationPlayer.animation_finished
	
	if scene is PackedScene:
		get_tree().current_scene.queue_free()
		scene = scene.instantiate()
		callback.call(scene)
		get_tree().get_root().add_child(scene)		
		get_tree().set_current_scene(scene)
	else:
		get_tree().current_scene.queue_free()
		scene = load(scene).instantiate()
		callback.call(scene)
		get_tree().get_root().add_child(scene)		
		get_tree().set_current_scene(scene)
		
	$AnimationPlayer.play_backwards("dissolve")
