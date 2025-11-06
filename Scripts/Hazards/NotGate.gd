extends Powerable

func _process_input():
	var on = inputs.find(true) == -1
	$AnimatedSprite2D.animation = &"on" if on else &"off"
	_set_output(on)
