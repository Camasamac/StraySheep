extends CanvasLayer
onready var playerattackindicator = get_node("UserInterface/AttackIndicatorAnimPlayer")

func _ready():
	if Input.is_action_pressed("ui_primary_attack_left"):
		playerattackindicator.play("Empty -> Slap")
