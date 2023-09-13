extends VBoxContainer

func _ready():
	$CheatEnableButton.pressed = Global.cheat_enabled

func _on_FullScreenButton_toggled(button_pressed):
	Global.fullscreenMode = OS.set_window_fullscreen(!OS.window_fullscreen)
	Global.fullscreenMode = button_pressed

func _on_CheatEnableButton_toggled(button_pressed):
	if Global.cheat_enabled == false:
		print("cheats enabled")
		Global.cheat_enabled == true
	elif Global.cheat_enabled == true:
		print("cheat disabled")
		Global.cheat_enabled == false
	Global.cheat_enabled = button_pressed
