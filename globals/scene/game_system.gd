extends Node

@onready var exit_panel = $ExitPanel
var is_ready = false

func _notification(what):
	if what == NOTIFICATION_READY:
		is_ready = true
	
	if what == NOTIFICATION_EXIT_TREE:
		is_ready = false
	
	_inmenu_notification(what)
	_ingame_notification(what)

func _inmenu_notification(what):
	if(is_ready && get_tree().get_current_scene() != HUDControl):
		match what:
			# show exit panel choice when alt+f4 pressed
			NOTIFICATION_WM_CLOSE_REQUEST:
				exit_panel.show()
			
			# show exit panel choice when back button on mobile pressed
			NOTIFICATION_WM_GO_BACK_REQUEST:
				var main_menu = SceneChanger.back_to_previous_scene()
				if main_menu:
					exit_panel.show()


func _ingame_notification(what):
	if(is_ready && get_tree().get_current_scene() is HUDControl):
		var pause_ui = get_tree().current_scene.pause_ui
		match what:
			# pause game when lost window focus
			NOTIFICATION_APPLICATION_FOCUS_OUT:
				pause_game(pause_ui)
			
			# pause game when alt+f4 pressed
			NOTIFICATION_WM_CLOSE_REQUEST:
				pause_game(pause_ui)

			# pause game when back button on mobile pressed
			NOTIFICATION_WM_GO_BACK_REQUEST:
				pause_game(pause_ui)
			
			# show exit panel choice when alt+f4 pressed
			NOTIFICATION_APPLICATION_PAUSED:
				pause_game(pause_ui)


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
