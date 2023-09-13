extends VBoxContainer

func _ready():
	pass # Replace with function body.

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	get_tree().change_scene("res://Game Scenes/TEST_Main Zone.tscn")

func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Title and Main Scenes/Options.tscn")
