extends Node2D

onready var mainbuttonsvbox = $CanvasLayer/MainMenuButtons
onready var saves = $CanvasLayer/Saves

func _ready():
	saves.visible = false

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	mainbuttonsvbox.visible = false
	saves.visible = true

func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Title and Main Scenes/Options.tscn")

func _on_Save1Button_pressed():
	Autoload.Save_Number = 1
	Autoload.load_game()
	init_scene()

func _on_Save2Button_pressed():
	Autoload.Save_Number = 2
	Autoload.load_game()
	init_scene()

func _on_Save3Button_pressed():
	Autoload.Save_Number = 3
	Autoload.load_game()
	init_scene()

func init_scene():
	get_tree().change_scene("res://Game Scenes/TEST_Main Zone.tscn")
