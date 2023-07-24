extends CanvasLayer


func change_scene(scene):
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	
	if scene is PackedScene:
		get_tree().change_scene_to_packed(scene)
	else:
		get_tree().change_scene_to_file(scene)
		
	$AnimationPlayer.play_backwards("dissolve")
