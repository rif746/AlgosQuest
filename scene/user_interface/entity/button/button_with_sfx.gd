extends Button
class_name ButtonSFX


func _on_pressed():
	$Hover.stop()
	$Clicked.play()



func _on_mouse_entered():
	$Hover.play()
	await $Hover.finished
