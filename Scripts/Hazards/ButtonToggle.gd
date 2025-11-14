extends PowerableButton

func _update_pressed(val):
	if (val):
		super(!inputs[0])
		_set_input(0, !inputs[0])
