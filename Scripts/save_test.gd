extends Control

onready var health_print = $TabContainer/Stat_Adjustments/HealthPrint
onready var increase_health = $TabContainer/Stat_Adjustments/VBoxContainer/IncreaseHealthButton
onready var decrease_health = $TabContainer/Stat_Adjustments/VBoxContainer/DecreaseHealthButton

onready var game_data = SaveFile.game_data

func _ready():
	health_print.value = game_data.health

func _on_IncreaseHealthButton_pressed():
	game_data.health = game_data.health + 10 if game_data.health <= 100 else 100
	update_health_print()

func _on_DecreaseHealthButton_pressed():
	game_data.health = game_data.health - 10 if game_data.health >= 10 else 10
	pass # Replace with function body.

func update_health_print():
	health_print.value = game_data.health
	SaveFile.save_data()
