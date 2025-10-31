class_name ButtonHold extends BaseAntButton

func _on_body_entered(body):
	if body is BaseAnt:
		_set_active(true)

func _on_body_exited(body):
	if body is BaseAnt:
		_set_active(false)
