class_name ButtonHold extends BaseAntButton

func _on_full_press():
	_set_active(true)

func _on_full_unpress():
	_set_active(false)
