extends PowerableButton

func _update_pressed(val):
	super(val)
	_set_input(0, val)
