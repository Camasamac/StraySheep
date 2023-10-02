extends KinematicBody2D

const UP = Vector2(0,-1)

onready var playernode = get_node("res://Assets/Player/2DPlayer.tscn")
onready var playerattackindicator = get_node("CanvasLayer/AttackIndicatorAnimPlayer")
export(String) var scene_to_load

var gravity = 50 # Gravity's strength.
var maximum_fall_speed = 50
const movement_speed = 200 # Determines the base movement speed of the player.
const maximum_jumpPower = -1000.0 # How much force used to make player high jump.
const minimum_jumpPower = -600.0 # How much force used to make the player small jump.

var player_position_X = Global.PlayerPosition_X
var player_position_Y = Global.PlayerPosition_Y

var player_position = Vector2(player_position_X, player_position_Y)

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_transform.origin = player_position

func _physics_process(delta):
	player_position_X = self.global_transform.origin.x
	player_position_Y = self.global_transform.origin.y
	
	Global.PlayerPosition_X = player_position_X
	Global.PlayerPosition_Y = player_position_Y
	Autoload.save_game()
	
	velocity.y += gravity
	#if velocity.y > maximum_fall_speed:
		#velocity.y = maximum_fall_speed
		# This above statement (velocity = maximum_fall_speed) SHOULD cap the gravity at 50 and not go beyond that.
	var isMoving: bool = false
	
	# Player movement code for pressing 'left' and 'right'.
	if Input.is_action_pressed("ui_left"):
		velocity.x = -movement_speed
		$AnimationPlayer.stop()
		isMoving = true
	elif Input.is_action_pressed("ui_right"):
		velocity.x = movement_speed
		$AnimationPlayer.stop()
		isMoving = true
	else:
		velocity.x = 0
	
	if(!isMoving):
		$AnimationPlayer.play("Idle")
	
	# As long as the player is touching a floor, they can jump using the space bar button.
	if is_on_floor():
		if Input.is_action_just_pressed("ui_jump"):
			velocity.y = maximum_jumpPower
	
	# This portion of the jumping code allows for the player to 'short hop'.
	if Input.is_action_just_released("ui_jump") && velocity.y < 0:
		velocity.y = 0
	
	if Input.is_action_pressed("ui_up"):
		print("go up")
		#velocity.y -= 100
		if Global.player_depth < 7:
			Global.player_depth += 1
			#if Input.is_action_pressed("ui_up"):
			set_collision_layer_bit(Global.player_depth - 1, false)
			set_collision_layer_bit(Global.player_depth, true)
			#get_collision_layer_bit(Global.player_depth)
			#if Input.is_action_just_released("ui_up"):
				#set_collision_layer_bit(Global.player_depth + 1, false)
				#set_collision_layer_bit(Global.player_depth, true)
				# what makes it so i can go down?!
		if Global.player_depth == 7:
			set_collision_layer_bit(6, true)
		print(Global.player_depth)
		
	if Input.is_action_pressed("ui_down"):
		print("go down")
		#velocity.y += 50
		# The above code will allow the player to fly when they enable jumping, could be used later.
		if Global.player_depth > 1:
			Global.player_depth -= 1
			#if Input.is_action_pressed("ui_down"):
			set_collision_layer_bit(Global.player_depth + 1, false)
			set_collision_layer_bit(Global.player_depth, true)
			#get_collision_layer_bit(Global.player_depth)
			#if Input.is_action_just_released("ui_down"):
				#set_collision_layer_bit(Global.player_depth - 1, false)
				#set_collision_layer_bit(Global.player_depth, true)
		if Global.player_depth == 1:
			set_collision_layer_bit(0, true)
		print(Global.player_depth)
	
	# ATTACK CODE
	# IF THERE IS NO ACTION FOR PRIMARY ATTACK LEFT, DOWN, UP OR RIGHT, IN THE BEGINNING
	# THE ATTACK ANIM SHOULD BE "EMPTY ATTACK", AS THERE IS NO SELECTED ATTACK FROM THE
	# USER CURRENTLY.
		
	if Input.is_action_pressed("ui_primary_attack_left"):
		playerattackindicator.play("Empty -> Slap")
	
	#print(velocity.y)
	move_and_slide(velocity , UP)
