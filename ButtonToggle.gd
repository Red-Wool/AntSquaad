class_name ButtonToggle extends BaseAntButton

func _on_body_entered(body):
	if body is BaseAnt:
		_set_active(!active)
