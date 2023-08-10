extends KinematicBody2D

const UP = Vector2(0,-1)

const gravity = 40 # Gravity's strength.
const movement_speed = 200 # Determines the base movement speed of the player.
const jumpPower = 1000.0 # How much force used to make player jump.

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.y += gravity
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -movement_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = movement_speed
	else:
		velocity.x = 0
	
	if is_on_floor():
		if Input.is_action_pressed("ui_jump"):
			velocity.y = -jumpPower
	
	print(velocity.y)
	move_and_slide(velocity , UP)
	
	#velocity.x = lerp(velocity.x,0,0.2)
