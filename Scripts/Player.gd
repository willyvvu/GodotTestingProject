extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var playerAccelX
export(float) var playerMaxMoveSpeed
export(float) var jumpVelocity
export(float) var gravity
export(float) var friction

var airtime = 0
enum JumpState {
	READY,
	JUMPING,
	FALLING
}
var jumpState = JumpState.READY

var linearVelocity = Vector2()

onready var animatedSprite = get_node("AnimatedSprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	
	
	var x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	#var y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	#if moveDirection.length() > 1:
	#	moveDirection = moveDirection.normalized()
	
	var playerDesiredAccelX = x * playerAccelX
	
	
	if(playerDesiredAccelX > 0):
		linearVelocity.x = min(linearVelocity.x + playerDesiredAccelX, playerMaxMoveSpeed)
	if(playerDesiredAccelX < 0):
		linearVelocity.x = max(linearVelocity.x + playerDesiredAccelX, -playerMaxMoveSpeed)


	if(linearVelocity.x > 0):
		linearVelocity.x = max(linearVelocity.x - friction, 0)
	if(linearVelocity.x < 0):
		linearVelocity.x = min(linearVelocity.x + friction, 0)


	if jumpState == JumpState.READY:
		if Input.is_action_just_pressed("jump"):
			jumpState = JumpState.JUMPING
	
	if jumpState == JumpState.JUMPING:
		if Input.is_action_pressed("jump") && airtime < 10:
			linearVelocity.y = -jumpVelocity
		else:
			jumpState = JumpState.FALLING

	if jumpState == JumpState.FALLING:
		if airtime == 0:
			jumpState = JumpState.READY
	
	linearVelocity.y += gravity
	
	var previousVelocityY = linearVelocity.y
	
	linearVelocity = move_and_slide(linearVelocity)

	if (linearVelocity.y < previousVelocityY):
		# hit the ground?
		airtime = 0
	else:
		airtime += 1

	if abs(playerDesiredAccelX) > 0.1:
		animatedSprite.flip_h = playerDesiredAccelX < 0

	# Animation control
	if jumpState != JumpState.READY:
		animatedSprite.animation = "Jump"
	elif abs(playerDesiredAccelX) < 0.1 || abs(linearVelocity.x) < 0.1:
		animatedSprite.animation = "Idle"
	else:
		animatedSprite.animation = "Run"

