tool
extends VisualScriptCustomNode

# The name of the custom node as it appears in the search.
func _get_caption():
	return "Get Input Direction 2D"

func _get_category():
	return "Input"

# The text displayed after the input port / sequence arrow.
func _get_text():
	return ""

func _get_input_value_port_count():
	return 0

# The types of the inputs per index starting from 0.
func _get_input_value_port_type(idx):
	return TYPE_OBJECT

func _get_output_value_port_count():
	return 1

# The types of outputs per index starting from 0.
func _get_output_value_port_type(idx):
	return TYPE_VECTOR2

# The text displayed before each output node per index.
func _get_output_value_port_name(idx):
	return "Direction"

func _has_input_sequence_port():
	return true

# The number of output sequence ports to use
# (has to be at least one if you have an input sequence port).
func _get_output_sequence_port_count():
	return 1

func _step(inputs, outputs, start_mode, working_mem):
	# start_mode can be checked to see if it is the first time _step is called.
	# This is useful if you only want to do an operation once.

	# working_memory is persistent between _step calls.

	# The inputs array contains the value of the input ports.

	var x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	var y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))

	# The outputs array is used to set the data of the output ports.

	outputs[0] = Vector2(x, y)

	# Return the error string if an error occurred, else the id of the next sequence port.
	return 0
