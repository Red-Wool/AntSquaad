extends PowerableButton

func _update_pressed(val):
	if (val):
		_set_input(0, true)
