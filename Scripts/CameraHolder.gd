extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var playerNode = get_parent()
onready var cameraNode = get_child(0)
export(Vector2) var offset
export(float) var smoothfactor

var MAX_PREVENT_LOOKUP : int = 50
var preventlookup : int = MAX_PREVENT_LOOKUP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var controlstick := Vector2(
		int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")),
		int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	)
	if controlstick.length() > 1:
		controlstick = controlstick.normalized()

	var lookingup = abs(controlstick.y) > 0.1
	preventlookup = clamp(preventlookup + (-1 if lookingup else 2), 0, MAX_PREVENT_LOOKUP)
	
	if preventlookup > 0:
		controlstick.y = 0
	
	cameraNode.position = lerp(cameraNode.position, 
	  #offset * playerNode.linearVelocity
	  offset * controlstick * 100
	, smoothfactor)
