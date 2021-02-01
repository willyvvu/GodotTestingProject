extends RayCast2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var nodeToMove = get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		nodeToMove.visible = true
		nodeToMove.position = self.to_local(get_collision_point())
	else:
		nodeToMove.visible = false
