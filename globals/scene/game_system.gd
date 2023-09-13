extends Node

@onready var exit_panel = $ExitPanel

func _notification(what):
	if get_tree():  
		if(get_tree().get_current_scene() is HUDControl):
			var pause_ui = get_tree().current_scene.pause_ui
			match what:
				# pause game when lost window focus
				MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
					pause_game(pause_ui)
				
				# pause game when alt+f4 pressed
				NOTIFICATION_WM_CLOSE_REQUEST:
					pause_game(pause_ui)

				# pause game when back button on mobile pressed
				NOTIFICATION_WM_GO_BACK_REQUEST:
					pause_game(pause_ui)
		else:
			match what:
				# show exit panel choice when alt+f4 pressed
				NOTIFICATION_WM_CLOSE_REQUEST:
					exit_panel.show()
				
				# show exit panel choice when alt+f4 pressed
				NOTIFICATION_APPLICATION_PAUSED:
					exit_panel.show()
				
				# show exit panel choice when back button on mobile pressed
				NOTIFICATION_WM_GO_BACK_REQUEST:
					exit_panel.show()

# pause game and show menu
func pause_game(ui: Node = null):
	get_tree().paused = true
	if ui:
		ui.show()


# unpause game and hide menu
func resume_game(ui: Node = null):
	get_tree().paused = false
	if ui:
		ui.hide()
