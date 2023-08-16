extends KinematicBody2D

const UP = Vector2(0,-1)

onready var playernode = get_node("res://Assets/Player/2DPlayer.tscn")
export(String) var scene_to_load

var gravity = 50 # Gravity's strength.
const movement_speed = 200 # Determines the base movement speed of the player.
const maximum_jumpPower = -1000.0 # How much force used to make player high jump.
const minimum_jumpPower = -600.0 # How much force used to make the player small jump.

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.y += gravity
	
	# Player movement code for pressing 'left' and 'right'.
	if Input.is_action_pressed("ui_left"):
		velocity.x = -movement_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = movement_speed
	else:
		velocity.x = 0
	
	# As long as the player is touching a floor, they can jump using the space bar button.
	if is_on_floor():
		if Input.is_action_pressed("ui_jump"):
			velocity.y = maximum_jumpPower
	
	# This portion of the jumping code allows for the player to 'short hop'.
	if Input.is_action_just_released("ui_jump") && velocity.y < 0:
		velocity.y = 0
	
	if Input.is_action_pressed("ui_up"):
		print("go up")
		#velocity.y -= 100
		if Global.player_depth < 7:
			Global.player_depth += 1
			set_collision_layer_bit(Global.player_depth + 1, true)
		if Global.player_depth == 7:
			set_collision_layer_bit(7, true)
		print(Global.player_depth)
		
	if Input.is_action_pressed("ui_down"):
		print("go down")
		#velocity.y += 50
		# The above code will allow the player to fly when they enable jumping, could be used later.
		if Global.player_depth > 1:
			Global.player_depth -= 1
			set_collision_layer_bit(Global.player_depth - 1, true)
			# not used yet
		if Global.player_depth == 1:
			set_collision_layer_bit(1, true)
		print(Global.player_depth)
	
	#print(velocity.y)
	move_and_slide(velocity , UP)
