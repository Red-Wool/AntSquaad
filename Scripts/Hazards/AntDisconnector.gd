class_name AntDisconnector extends Area2D


func _on_body_entered(body):
	if body is PlayerAnt:
		if (body.disconnector_count == 0):
			body._disconnect_ants()
		body.disconnector_count += 1

func _on_body_exited(body):
	if body is PlayerAnt:
		body.disconnector_count -= 1
