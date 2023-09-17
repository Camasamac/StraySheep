extends KinematicBody2D
class_name Enemy

onready var anim = $TextureRect
onready var player_detection = $PlayerDetectionArea/CollisionShape2D
onready var attack_range = $AttackRange/CollisionShape2D
onready var hit_range = $Hitbox/CollisionShape2D

var reference_player

var player_in_range = false

var gravity = 100
var walk_speed = 60

var velocity = Vector2()
var direction = Vector2()

var state = states.IDLE

enum states {
	IDLE,
	RUN,
	ATTACK,
	HURT,
	DEATH
}

var list_states = []

func _ready():
	for i in states:
		list_states.append(states)

func _process(delta):
	handle_physics(delta)
	handle_states()
	handle_flipping()
	
	if reference_player:
		print("there is the player")
	
	if player_in_range:
		print("attack now")
	
	if Input.is_action_just_pressed("ui_primary_attack_right"):
		state = states.ATTACK

func handle_physics(delta):
	velocity.y += gravity * delta
	velocity.x = direction.x
	
	move_and_slide(velocity, Vector2.UP)

func handle_flipping():
	direction = (reference_player.global_position - global_position).normalized()
	
	if direction.x < 0:
		anim.flip_h = true
	elif direction.x > 0:
		anim.flip_h = false

func handle_states():
	match state:
		states.IDLE:
			anim.play("Idle")
		states.RUN:
			anim.play("Run")
		states.ATTACK:
			anim.play("Attack")
			# once the animation reaches the final frame, go back to idle
			if anim.frame == 9:
				state = states.IDLE
		states.HURT:
			anim.play("Hurt")
			if anim.frame == 10:
				state = states.IDLE
		states.DEATH:
			anim.play("Death")
			
func _on_PlayerDetectionArea_body_entered(body):
	if body.name == "2DPlayer":
		reference_player = body

func _on_AttackRange_body_entered(body):
	if body.name == "2DPlayer":
		player_in_range = true
