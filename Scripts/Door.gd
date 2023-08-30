extends Area2D
export(String) var scene_to_load

var entered = false

func _on_Area2D_body_entered(body: PhysicsBody2D):
	entered = true

func _on_Area2D_body_exited(body):
	entered = false

func _process(delta):
	if entered == true:
		if Input.is_action_pressed("ui_accept"):
			get_tree().change_scene(scene_to_load)
