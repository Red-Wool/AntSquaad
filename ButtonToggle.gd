class_name ButtonToggle extends BaseAntButton

var count : int = 0

func _on_body_entered(body):
	if body is BaseAnt or body is GrabbableFile:
		if (count == 0):
			_set_active(!active)
		count += 1

func _on_body_exited(body):
	if body is BaseAnt or body is GrabbableFile:
		count -= 1
