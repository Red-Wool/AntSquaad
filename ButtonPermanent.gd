class_name ButtonPermanent extends BaseAntButton

func _on_body_entered(body):
	if body is BaseAnt or body is GrabbableFile:
		_set_active(true)
