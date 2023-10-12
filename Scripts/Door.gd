extends Area2D
export(String) var scene_to_load

var entered = false


func _on_Area2D_body_entered(body: PhysicsBody2D):
	entered = true
	if entered == true and Global.player_depth == 7:
		if Input.is_action_pressed("ui_accept"):
			get_tree().change_scene(scene_to_load)
	if entered == true and Global.player_depth == 6: # NEED TO SPECIFY THE DOOR THAT YOU PLAN ON GOING THROUGH
		# IF YOU HAVE EVERY DEPTH LISTED WITHOUT DOORS TO SUIT THEM, THIS EXCLUSIVITY EXERCISE IS IN VAIN.
		if Input.is_action_pressed("ui_accept"):
			get_tree().change_scene(scene_to_load)
	# Will need some reworking to determine what the player's depth level is to enable going through the door.

func _on_Area2D_body_exited(body):
	entered = false
